// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";
import "forge-std/console2.sol";

contract C4UpgradeSweepTest is Test {
    Setup setup;
    Solution sol;

    address player = vm.addr(1);

    function setUp() public {
        // Player startet bei 0, soll am Ende >= 10 ether haben
        vm.deal(player, 0);

        // Setup lädt 10 ether in den Proxy
        setup = new Setup{value: 10 ether}();
        sol = new Solution();
    }

    function test_C4_upgrade_sweep() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        console2.log("FLAG{missionC_C4_upgrade_sweep}");
    }
}