// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

<<<<<<< HEAD
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
=======
contract Voter {
    uint256 public votes;
    mapping(address => bool) public hasVoted;
    
    // BUG: Diese Funktion könnte durch Calls umgangen werden,
    // da der State-Change nicht erzwungen wird
    function vote() external {
        require(!hasVoted[msg.sender], "Already voted");
        votes += 1;
        hasVoted[msg.sender] = true;
    }
    
    function getVotes() external view returns (uint256) {
        return votes;
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }
}

contract Setup {
<<<<<<< HEAD
    Counter public counter;
    
    constructor() {
        counter = new Counter();
    }
    
    function isSolved() external view returns (bool) {
        return counter.count() == 3 && counter.lastCaller() != address(0);
=======
    Voter public voter;
    
    constructor() {
        voter = new Voter();
    }
    
    function isSolved() external view returns (bool) {
        // Gelöst wenn 5 Votes abgegeben wurden
        return voter.votes() == 5;
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }
}