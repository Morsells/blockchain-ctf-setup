// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B1StateReadWriteTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        sol = new Solution();
    }

    function test_B1_state_read_write() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(), "not solved");
        emit log_string("FLAG{mission_B1_state_read_write_solved}");
    }
    
    function test_counter_initially_zero() public view {
        Counter counter = setup.counter();
        assertEq(counter.counter(), 0, "Counter should start at 0");
    }
}