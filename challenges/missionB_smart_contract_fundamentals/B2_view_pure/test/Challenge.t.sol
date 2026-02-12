// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "lib/forge-std/src/Test.sol";
import "../src/Challenge.sol";

contract B2ViewPureTest is Test {
    Setup setup;
    ViewPureDemo demo;
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        demo = setup.demo();
    }

    function test_initialState() public view {
        assertEq(demo.data(), 42, "data should be 42");
        assertEq(demo.message(), "Blockchain", "message should be 'Blockchain'");
    }

    function test_getData() public {
        uint256 result = demo.getData();
        assertEq(result, 42, "getData() should return 42");
    }

    function test_getMessageLength() public {
        uint256 result = demo.getMessageLength();
        assertEq(result, 10, "'Blockchain' has 10 characters");
    }

    function test_add() public {
        uint256 result = demo.add(5, 7);
        assertEq(result, 12, "5 + 7 should be 12");
        
        result = demo.add(100, 200);
        assertEq(result, 300, "100 + 200 should be 300");
    }

    function test_concatenate() public {
        string memory result = demo.concatenate("Hello", "World");
        assertEq(result, "HelloWorld", "Hello + World = HelloWorld");
        
        result = demo.concatenate("Solidity", "Rocks");
        assertEq(result, "SolidityRocks", "Solidity + Rocks = SolidityRocks");
    }

    function test_viewModifier() public {
        uint256 before = demo.data();
        demo.getData();
        uint256 afterwards = demo.data();
        assertEq(before, afterwards, "view function should not change state");
        
        before = demo.data();
        demo.getMessageLength();
        afterwards = demo.data();
        assertEq(before, afterwards, "view function should not change state");
    }

    function test_pureModifier() public view {
        // pure functions cannot read or write state
        // This is enforced by the compiler
        demo.add(1, 2);
        demo.concatenate("a", "b");
    }

    function test_isSolved() public {
        assertTrue(setup.isSolved(), "functions not correctly implemented");
        emit log_string("FLAG{mission_B2_view_pure_solved}");
    }
}