// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B7MappingsStructsTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        vm.deal(player, 0);
        setup = new Setup{value: 1 ether}();
        sol = new Solution();
    }

    function test_B7_mappings_structs() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        emit log_string("FLAG{mission_B7_mappings_structs_solved}");
    }
    
    function test_registry_has_ether() public view {
        UserRegistry registry = setup.registry();
        assertEq(address(registry).balance, 1 ether, "Registry should have 1 ether");
    }
}