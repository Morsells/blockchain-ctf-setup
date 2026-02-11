// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";

contract SetupD1 {
    SimpleAMM public amm;

    constructor() {
        // Start mit 1_000 A und 2_000 B
        amm = new SimpleAMM(1_000 ether, 2_000 ether);
    }

    function isSolved(address /*player*/) external pure returns (bool) {
        return false; // D1 hat keine Exploit-Bedingung
    }
}
