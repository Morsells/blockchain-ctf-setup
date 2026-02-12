// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B5EventsLogsTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        sol = new Solution();
    }

    function test_B5_events_logs() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(), "not solved");
        emit log_string("FLAG{mission_B5_events_logs_solved}");
    }
    
    function test_system_initially_active() public view {
        Logger logger = setup.logger();
        assertEq(logger.systemActive(), true, "System should be active initially");
    }
}