// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/Challenge.sol";
import "../src/Solution.sol";

contract D3Test {
    event log_string(string);
    SetupD3 setup;
    SolutionD3 sol;

    function setUp() public {
        setup = new SetupD3();
        sol = new SolutionD3();
    }

    function test_borrow_over_limit_but_passes() public {
        address attacker = address(sol);
        uint256 normalMax = setup.pool().maxBorrowAtPrice(attacker, setup.initialPrice());

        sol.manipulateAndBorrow(setup.amm(), setup.pool());

        uint256 debt = setup.pool().debtB(attacker);
        require(debt > normalMax, "zu wenig debt");
        require(setup.pool().poolB() < 10_000 ether, "no borrow");

        emit log_string("FLAG{missionD_D3_collateral_logic}");
    }
}

