// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "lib/forge-std/src/Test.sol";
import "../src/Challenge.sol";

contract B3TransactionsCallsTest is Test {
    Setup setup;
    Counter counter;
    address user1 = address(0x1);
    address user2 = address(0x2);
    address user3 = address(0x3);

    function setUp() public {
        setup = new Setup();
        counter = setup.counter();
    }

    function test_increment() public {
        vm.prank(user1);
        uint256 result = counter.increment();
        
        assertEq(result, 1, "increment() should return 1");
        assertEq(counter.count(), 1, "count should be 1");
        assertEq(counter.lastCaller(), user1, "lastCaller should be user1");
    }

    function test_getCount() public {
        vm.prank(user1);
        counter.increment();
        
        assertEq(counter.getCount(), counter.count(), "getCount() should return count");
    }

    function test_getLastCaller() public {
        vm.prank(user1);
        counter.increment();
        
        assertEq(counter.getLastCaller(), counter.lastCaller(), "getLastCaller() should return lastCaller");
    }

    function test_constructor() public {
        assertTrue(address(counter) != address(0), "counter was not initialized");
    }

    function test_isSolved() public {
        assertFalse(setup.isSolved(), "should not be solved yet");
        
        vm.prank(user1); counter.increment();
        vm.prank(user2); counter.increment();
        vm.prank(user3); counter.increment();
        
        assertTrue(setup.isSolved(), "should be solved after 3 transactions");
        
        emit log_string("FLAG{mission_B3_transactions_calls_solved}");
    }
}