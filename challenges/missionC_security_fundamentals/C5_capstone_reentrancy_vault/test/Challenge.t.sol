@'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Challenge.sol";
import "../src/Solution.sol";

contract ChallengeTest is Test {
    Setup setup;
    Solution sol;
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        sol = new Solution();
    }

    function test_solve() public {
        vm.startPrank(player);
        sol.solve(setup);
        vm.stopPrank();

        assertTrue(setup.isSolved(player), "not solved");
    }
}
'@ | Set-Content -Encoding UTF8 "templates\foundry-challenge-template\test\Challenge.t.sol"