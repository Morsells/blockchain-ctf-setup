// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Counter {
    uint256 public counter;
    address public owner;

    constructor() {
        owner = msg.sender;
        counter = 0;
    }

    // BUG: Diese Funktion sollte nur vom Owner aufgerufen werden können,
    // ist aber momentan ungeschützt.
    function setCounter(uint256 newValue) external {
        counter = newValue;
    }

    // Diese Funktion gibt den aktuellen Counter-Wert zurück
    function getCounter() external view returns (uint256) {
        return counter;
    }
}

contract Setup {
    Counter public counter;

    constructor() {
        counter = new Counter();
    }

    function isSolved() external view returns (bool) {
        // Gelöst wenn counter == 100
        return counter.counter() == 100;
    }
}