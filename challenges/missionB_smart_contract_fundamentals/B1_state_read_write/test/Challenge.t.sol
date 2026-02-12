// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "../../../lib/forge-std/src/Test.sol";
import "../src/Challenge.sol";

contract B1StateReadWriteTest is Test {
    Setup setup;
    Counter counter;
    address player = vm.addr(1);

    function setUp() public {
        setup = new Setup();
        counter = setup.counter();
    }

    function test_initialState() public view {
        assertEq(counter.counter(), 0, "Counter should start at 0");
        assertEq(counter.getCounter(), 0, "getCounter() should return 0");
    }

    function test_increment() public {
        vm.prank(player);
        counter.increment();
        
        assertEq(counter.counter(), 1, "Counter should be 1 after increment");
        assertEq(counter.getCounter(), 1, "getCounter() should return 1");
    }

    function test_multipleIncrements() public {
        for(uint i = 0; i < 5; i++) {
            vm.prank(player);
            counter.increment();
        }
        
        assertEq(counter.counter(), 5, "Counter should be 5 after 5 increments");
    }

    function test_isSolved() public {
        assertFalse(setup.isSolved(), "should not be solved yet");

        for(uint i = 0; i < 5; i++) {
            vm.prank(player);
            counter.increment();
        }

        assertTrue(setup.isSolved(), "not solved");
        emit log_string("FLAG{mission_B1_state_read_write_solved}");
    }

    function test_viewDoesNotChangeState() public {
        uint256 before = counter.counter();
        counter.getCounter();
        uint256 later = counter.counter();
        
        assertEq(before, later, "view function should not change state");
    }
}