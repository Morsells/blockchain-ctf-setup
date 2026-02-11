// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleOracle.sol";

contract LendingPool {
    SimpleOracle public oracle;
    uint256 public constant LTV_BPS = 5000; // 50%
    uint256 public constant BPS = 10_000;

    mapping(address => uint256) public collateralA;
    mapping(address => uint256) public debtB;
    uint256 public poolB;

    constructor(SimpleOracle _o, uint256 initialB){
        oracle = _o;
        poolB = initialB;
    }

    function depositA(uint256 amount) external {
        require(amount > 0, "bad amount");
        collateralA[msg.sender] += amount;
    }

    function collateralValue(address user, uint256 price) public view returns (uint256) {
        return (collateralA[user] * price) / 1e18;
    }

    function maxBorrowAtPrice(address user, uint256 price) public view returns (uint256) {
        uint256 value = collateralValue(user, price);
        return (value * LTV_BPS) / BPS;
    }

    function maxBorrow(address user) public view returns (uint256) {
        return maxBorrowAtPrice(user, oracle.priceAinB());
    }

    function healthFactor(address user) external view returns (uint256) {
        if (debtB[user] == 0) return type(uint256).max;
        return (maxBorrow(user) * 1e18) / debtB[user];
    }

    function borrowB(uint256 amount) external {
        require(amount > 0, "bad amount");
        uint256 price = oracle.priceAinB();
        uint256 newDebt = debtB[msg.sender] + amount;
        require(maxBorrowAtPrice(msg.sender, price) >= newDebt, "insufficient collateral");
        require(poolB >= amount, "no liquidity");
        poolB -= amount;
        debtB[msg.sender] = newDebt;
    }
}
