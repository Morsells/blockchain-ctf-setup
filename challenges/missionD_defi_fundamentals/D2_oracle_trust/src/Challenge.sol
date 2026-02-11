// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";
import "./SimpleOracle.sol";

contract SetupD2 {
    SimpleAMM public amm;
    SimpleOracle public oracle;

    constructor() {
        amm = new SimpleAMM(1_000 ether, 2_000 ether);
        oracle = new SimpleOracle(amm);
    }

    function isSolved(address /*player*/) external pure returns (bool) {
        return false; // Test prüft Manipulationserfolg
    }
}
