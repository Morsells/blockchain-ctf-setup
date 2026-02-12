// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Counter {
    uint256 public count;
    address public lastCaller;
    
    function increment() external returns (uint256) {
        count += 1;
        lastCaller = msg.sender;
        return count;
    }
    
    function getCount() external view returns (uint256) {
        return count;
    }
    
    function getLastCaller() external view returns (address) {
        return lastCaller;
    }
}

contract Setup {
    Counter public counter;
    
    constructor() {
        counter = new Counter();
    }
    
    function isSolved() external view returns (bool) {
        return counter.count() == 3 && counter.lastCaller() != address(0);
    }
}