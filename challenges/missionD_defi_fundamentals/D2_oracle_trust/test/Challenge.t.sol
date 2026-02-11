// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/Challenge.sol";
import "../src/Solution.sol";

contract D2Test {
    event log_string(string);
    SetupD2 setup;
    SolutionD2 sol;

    function setUp() public {
        setup = new SetupD2();
        sol = new SolutionD2();
    }

    function test_oracle_manipulated() public {
        uint256 beforeP = setup.oracle().priceAinB();
        require(beforeP == 2e18, "start preis");

        sol.manipulateUp(setup.amm(), setup.oracle(), 3_000 ether);

        uint256 afterP = setup.oracle().priceAinB();
        require(afterP > 8e18, "preis zu klein");
        require(setup.amm().reserveA() < 1_000 ether, "reserveA unveraendert");

        emit log_string("FLAG{missionD_D2_oracle_trust}");
    }
}

