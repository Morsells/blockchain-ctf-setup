// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";
import "./Challenge.sol";

contract SolutionD1 {
    // Spot-Preis A in B (18 Dezimalstellen)
    function spotAinB(SimpleAMM amm) public view returns (uint256) {
        return (amm.reserveB() * 1e18) / amm.reserveA();
    }

    // erwarteter Output für A->B (mit Fee)
    function quoteOutAtoB(SimpleAMM amm, uint256 amountIn) public view returns (uint256) {
        return amm.getAmountOut(amountIn, amm.reserveA(), amm.reserveB());
    }

    // effektiver Preis (B pro A) für einen Trade
    function effectivePrice(SimpleAMM amm, uint256 amountIn) external view returns (uint256) {
        uint256 out = quoteOutAtoB(amm, amountIn);
        return (out * 1e18) / amountIn;
    }

    // A->B Swap simulieren und neuen Spot-Preis liefern
    function priceAfterSwapAforB(SimpleAMM amm, uint256 amountIn) external returns (uint256) {
        amm.swapAforB(amountIn);
        return spotAinB(amm);
    }
}

