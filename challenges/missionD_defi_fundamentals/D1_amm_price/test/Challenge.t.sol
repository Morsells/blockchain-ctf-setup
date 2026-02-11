// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/Challenge.sol";
import "../src/SimpleAMM.sol";
import "../src/Solution.sol";

contract D1Test {
    event log_string(string);
    SetupD1 setup;
    SolutionD1 sol;

    function setUp() public {
        setup = new SetupD1();
        sol = new SolutionD1();
    }

    function test_prices_and_quotes() public {
        SimpleAMM amm = setup.amm();

        uint256 spot = sol.spotAinB(amm);
        require(spot == 2e18, "Spot falsch");

        uint256 amountIn = 100 ether;
        uint256 out = amm.getAmountOut(amountIn, amm.reserveA(), amm.reserveB());

        uint256 amountInWithFee = (amountIn * (amm.BPS() - amm.FEE_BPS())) / amm.BPS();
        uint256 expectedOut = (amountInWithFee * amm.reserveB()) / (amm.reserveA() + amountInWithFee);
        require(out == expectedOut, "Quote falsch");

        uint256 effPrice = sol.effectivePrice(amm, amountIn);
        require(effPrice < spot, "Effektiv zu hoch");

        uint256 newSpot = sol.priceAfterSwapAforB(amm, amountIn);
        require(newSpot < spot, "Spot sollte fallen");

        uint256 neededIn = amm.getAmountIn(out, amm.reserveA(), amm.reserveB());
        require(neededIn >= amountIn, "AmountIn falsch");

        emit log_string("FLAG{missionD_D1_amm_price}");
    }
}

