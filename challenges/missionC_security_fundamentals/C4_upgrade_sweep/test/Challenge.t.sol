// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Player.sol";

contract C4UpgradeSweepTest is Test {
    Setup setup;
    Player solver;

    address player = vm.addr(1);

    function setUp() public {
        vm.deal(player, 0);
        setup = new Setup{value: 10 ether}();
        solver = new Player();
    }

    function test_c4_upgrade_sweep() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        solver.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");

        emit log_string("FLAG{missionC_C4_upgrade_sweep}");
    }
}