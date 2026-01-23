// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract C5CapstoneReentrancyVaultTest is Test {
    Setup setup;
    Solution sol;

    address player = vm.addr(1);

    function setUp() public {
        // Player bekommt Start-Ether für die Seed-Deposit
        vm.deal(player, 1 ether);

        // Setup lädt 2 Ether Treasury in die Vault
        setup = new Setup{value: 2 ether}();
        sol = new Solution();
    }

    function test_C5_capstone_reentrancy_vault() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve{value: 0.1 ether}(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        emit log_string("FLAG{missionC_capstone_reentrancy_reward_vault}");
    }
}