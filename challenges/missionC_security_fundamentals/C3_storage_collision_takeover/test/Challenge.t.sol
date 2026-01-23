// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";
import "forge-std/console2.sol";

contract C3StorageCollisionTest is Test {
    Setup setup;
    Solution sol;

    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        sol = new Solution();
    }

    function test_C3_storage_collision_takeover() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        console2.log("FLAG{missionC_C3_storage_collision}");
    }
}