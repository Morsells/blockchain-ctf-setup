// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";
import "./SimpleOracle.sol";
import "./LendingPool.sol";

contract SetupD3 {
    SimpleAMM public amm;
    SimpleOracle public oracle;
    LendingPool public pool;
    uint256 public initialPrice;

    constructor(){
        amm = new SimpleAMM(1_000 ether, 2_000 ether);
        oracle = new SimpleOracle(amm);
        pool = new LendingPool(oracle, 10_000 ether);
        initialPrice = amm.spotPriceAinB();
    }

    function isSolved(address /*player*/) external pure returns(bool){
        return false;
    }
}

