// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleOracle.sol";
import "./TokenA.sol";
import "./TokenB.sol";

contract LendingPool {
    SimpleOracle public oracle;
    TokenA public tokenA;
    TokenB public tokenB;

    uint256 public constant LTV_BPS = 5000; // 50%
    uint256 public constant BPS = 10_000;

    mapping(address => uint256) public collA;
    mapping(address => uint256) public debtB;

    constructor(SimpleOracle _o, TokenA _a, TokenB _b, uint256 seedB) {
        oracle = _o;
        tokenA = _a;
        tokenB = _b;
        tokenB.mintForTraining(address(this), seedB);
    }

    function depositA(uint256 amount) external {
        require(amount > 0, "bad amount");
        require(tokenA.transferFrom(msg.sender, address(this), amount), "transfer A");
        collA[msg.sender] += amount;
    }

    function maxBorrow(address user) public view returns (uint256) {
        uint256 price = oracle.priceAinB();
        uint256 value = (collA[user] * price) / 1e18;
        return (value * LTV_BPS) / BPS;
    }

    function borrowB(uint256 amount) external {
        require(amount > 0, "bad amount");
        uint256 newDebt = debtB[msg.sender] + amount;
        require(maxBorrow(msg.sender) >= newDebt, "bad collateral");
        require(tokenB.balanceOf(address(this)) >= amount, "no liquidity");
        debtB[msg.sender] = newDebt;
        require(tokenB.transfer(msg.sender, amount), "transfer B");
    }
}

