// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Counter {
    uint256 public counter;
    address public owner;

    constructor() {
        owner = msg.sender;
        counter = 0;
    }

<<<<<<< HEAD
    // ✅ State-schreibende Funktion
    function increment() public {
        counter += 1;
    }

    // ✅ State-lesende Funktion (view)
    function getCounter() public view returns (uint256) {
=======
    // BUG: Diese Funktion sollte nur vom Owner aufgerufen werden können,
    // ist aber momentan ungeschützt.
    function setCounter(uint256 newValue) external {
        counter = newValue;
    }

    // Diese Funktion gibt den aktuellen Counter-Wert zurück
    function getCounter() external view returns (uint256) {
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
        return counter;
    }
}

contract Setup {
    Counter public counter;

    constructor() {
        counter = new Counter();
    }

    function isSolved() external view returns (bool) {
<<<<<<< HEAD
        return counter.counter() == 5;
=======
        // Gelöst wenn counter == 100
        return counter.counter() == 100;
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }
}