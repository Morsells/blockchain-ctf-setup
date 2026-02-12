// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Counter {
    uint256 public counter;
    address public owner;

    constructor() {
        owner = msg.sender;
        counter = 0;
    }

    // ✅ State-schreibende Funktion
    function increment() public {
        counter += 1;
    }

    // ✅ State-lesende Funktion (view)
    function getCounter() public view returns (uint256) {
        return counter;
    }
}

contract Setup {
    Counter public counter;

    constructor() {
        counter = new Counter();
    }

    function isSolved() external view returns (bool) {
        return counter.counter() == 5;
    }
}