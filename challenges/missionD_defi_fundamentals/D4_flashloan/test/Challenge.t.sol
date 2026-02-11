// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/Challenge.sol";
import "../src/Solution.sol";

contract D4Test {
    event log_string(string);
    SetupD4 setup;
    SolutionD4 sol;

    function setUp() public {
        setup = new SetupD4();
        sol = new SolutionD4();
    }

    function test_flashloan_flow() public {
        uint256 startFL = setup.tokenB().balanceOf(address(setup.fl()));
        uint256 startPool = setup.tokenB().balanceOf(address(setup.pool()));

        sol.run(setup.fl(), setup.amm(), setup.pool(), setup.tokenA(), setup.tokenB());

        uint256 fee = setup.fl().fee(3_000 ether);
        require(setup.tokenB().balanceOf(address(setup.fl())) >= startFL + fee, "flash not repaid");
        require(setup.tokenB().balanceOf(address(setup.pool())) < startPool, "no borrow");
        require(setup.tokenB().balanceOf(address(sol)) > 0, "no profit");

        emit log_string("FLAG{missionD_D4_flashloan}");
    }
}

