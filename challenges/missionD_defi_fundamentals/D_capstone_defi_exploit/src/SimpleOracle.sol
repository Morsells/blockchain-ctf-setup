// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";

contract SimpleOracle {
    SimpleAMM public amm;
    constructor(SimpleAMM _amm){ amm = _amm; }
    function priceAinB() external view returns(uint256){ return amm.spotPriceAinB(); }
}

