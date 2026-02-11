// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./TokenA.sol";
import "./TokenB.sol";
import "./SimpleAMM.sol";
import "./SimpleOracle.sol";
import "./LendingPool.sol";
import "./FlashLoanProvider.sol";

contract SetupD4 {
    TokenA public tokenA;
    TokenB public tokenB;
    SimpleAMM public amm;
    SimpleOracle public oracle;
    LendingPool public pool;
    FlashLoanProvider public fl;

    constructor() {
        tokenA = new TokenA();
        tokenB = new TokenB();
        amm = new SimpleAMM(tokenA, tokenB, 1_000 ether, 2_000 ether);
        oracle = new SimpleOracle(amm);
        pool = new LendingPool(oracle, tokenA, tokenB, 10_000 ether);
        fl = new FlashLoanProvider(tokenB, 5_000 ether);
    }

    function isSolved(address /*p*/) external pure returns (bool) {
        return false;
    }
}

