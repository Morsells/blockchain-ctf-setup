// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./TokenB.sol";

interface IFlashBorrower {
    function onFlashLoan(uint256 amount, uint256 fee, bytes calldata data) external returns (bytes32);
}

contract FlashLoanProvider {
    uint256 public constant BPS = 10_000;
    uint256 public constant FEE_BPS = 5; // 0.05%

    TokenB public tokenB;

    constructor(TokenB _b, uint256 seed) {
        tokenB = _b;
        tokenB.mintForTraining(address(this), seed);
    }

    function fee(uint256 amount) public pure returns (uint256) {
        return (amount * FEE_BPS) / BPS;
    }

    function flash(address borrower, uint256 amount, bytes calldata data) external {
        uint256 start = tokenB.balanceOf(address(this));
        require(start >= amount, "no funds");

        require(tokenB.transfer(borrower, amount), "transfer out");
        uint256 f = fee(amount);

        bytes32 ok = IFlashBorrower(borrower).onFlashLoan(amount, f, data);
        require(ok == keccak256("OK"), "callback");

        require(tokenB.balanceOf(address(this)) >= start + f, "not repaid");
    }
}

