// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract C1AccessControlTest is Test {
    Setup setup;
    Solution sol;

    address player = vm.addr(1);

    function setUp() public {
        // Player startet bei 0, soll am Ende >= 1 ether haben
        vm.deal(player, 0);

        // Setup lädt 1 ether in die Vault
        setup = new Setup{value: 1 ether}();
        sol = new Solution();
    }

    function test_C1_access_control() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");

        emit log_string("FLAG{missionC_C1_access_control}");
    }
}