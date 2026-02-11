// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";

// Naives Oracle: speichert nur den letzten Spot-Preis
contract SimpleOracle {
    SimpleAMM public amm;
    uint256 public lastPrice;

    constructor(SimpleAMM _amm) {
        amm = _amm;
        lastPrice = _amm.spotPriceAinB();
    }

    function update() external {
        lastPrice = amm.spotPriceAinB();
    }

    function priceAinB() external view returns (uint256) {
        return lastPrice;
    }
}

