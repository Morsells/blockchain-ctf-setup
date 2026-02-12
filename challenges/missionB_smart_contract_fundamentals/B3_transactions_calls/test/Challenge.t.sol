// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B3TransactionsCallsTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        sol = new Solution();
    }

    function test_B3_transactions_calls() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(), "not solved");
        emit log_string("FLAG{mission_B3_transactions_calls_solved}");
    }
    
    function test_initial_votes_zero() public view {
        Voter voter = setup.voter();
        assertEq(voter.votes(), 0, "Initial votes should be 0");
    }
}