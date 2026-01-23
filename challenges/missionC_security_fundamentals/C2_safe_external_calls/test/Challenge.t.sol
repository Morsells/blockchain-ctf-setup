// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";
import "forge-std/console2.sol";

contract C2SafeExternalCallsTest is Test {
    Setup setup;
    Solution sol;

    address player = vm.addr(1);

    function setUp() public {
        vm.deal(player, 1 ether);
        setup = new Setup{value: 1 ether}();
        sol = new Solution();
    }

    function test_C2_safe_external_calls() public {
        assertFalse(setup.isSolved(player), "should not be solved yet");

        vm.startPrank(player);
        sol.solve{value: 0.1 ether}(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
        console2.log("FLAG{missionC_C2_safe_external_calls}");
    }
}