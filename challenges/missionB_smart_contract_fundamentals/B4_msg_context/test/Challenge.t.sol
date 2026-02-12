// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract B4MsgContextTest is Test {
    Setup setup;
    Solution sol;
    
    address player = vm.addr(1);

    function setUp() public {
        // Player startet bei 0 ETH
        vm.deal(player, 0);
        
        // Setup Contract erhält 1 ETH
        setup = new Setup{value: 1 ether}();
        sol = new Solution();
    }

    function test_B4_msg_context() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        emit log_string("FLAG{mission_B4_msg_context_solved}");
    }
    
    function test_bank_has_initial_ether() public view {
        SimpleBank bank = setup.bank();
        assertEq(address(bank).balance, 1 ether, "Bank should have 1 ether initially");
    }
}