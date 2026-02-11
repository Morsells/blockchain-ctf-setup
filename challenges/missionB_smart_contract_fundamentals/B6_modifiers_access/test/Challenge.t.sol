// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B6ModifiersAccessTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        vm.deal(player, 0);
        setup = new Setup{value: 1 ether}();
        sol = new Solution();
    }

    function test_B6_modifiers_access() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        emit log_string("FLAG{mission_B6_modifiers_access_solved}");
    }
    
    function test_vault_has_ether() public view {
        SecureVault vault = setup.vault();
        assertEq(address(vault).balance, 1 ether, "Vault should have 1 ether");
    }
}