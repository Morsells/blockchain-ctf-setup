// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
<<<<<<< HEAD

contract B5EventsLogsTest is Test {
    Setup setup;
    Logger logger;

=======
import "../src/Solution.sol";

contract B5EventsLogsTest is Test {
    Setup setup;
    Solution sol;
    
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
<<<<<<< HEAD
        logger = setup.logger();
    }

    function test_system_initially_active() public view {
        assertEq(logger.systemActive(), true, "System should be active initially");
=======
        sol = new Solution();
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }

    function test_B5_events_logs() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        vm.startPrank(player);
<<<<<<< HEAD

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
=======
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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
