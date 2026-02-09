// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol"; // for the player version, switch the import to Player.sol

contract C1AccessControlTest is Test {
    Setup setup;
    Solution solver; // for the player version, switch this to "Player solver"

    address player = vm.addr(1);

    function setUp() public {
        vm.deal(player, 0);
        setup = new Setup{value: 1 ether}();
        solver = new Solution(); // for the player version, change this to "new Player()"
    }

    function test_c1_access_control() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        solver.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");

        emit log_string("FLAG{missionC_C1_access_control}");
    }
}