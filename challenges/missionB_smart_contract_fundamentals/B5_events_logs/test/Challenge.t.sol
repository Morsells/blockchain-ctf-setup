// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract B5EventsLogsTest is Test {
    Setup setup;
    Logger logger;

    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        logger = setup.logger();
    }

    function test_system_initially_active() public view {
        assertEq(logger.systemActive(), true, "System should be active initially");
    }

    function test_B5_events_logs() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        vm.startPrank(player);

        /*
            Step 1:
            Call logAction(). Even if this later reverted,
            the event would already be emitted (bug).
        */
        logger.logAction("Logging before require");

        vm.stopPrank();

        /*
            Step 2:
            Disable the system.

            IMPORTANT:
            Setup deployed Logger, so Setup is the admin.
            We must prank as Setup.
        */
        vm.prank(address(setup));
        logger.toggleSystem();

        assertTrue(setup.isSolved(), "not solved");
        emit log_string("FLAG{mission_B5_events_logs_solved}");
    }
}
