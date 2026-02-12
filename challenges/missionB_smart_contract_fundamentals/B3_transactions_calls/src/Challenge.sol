// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

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
    }
}

contract Setup {
    Voter public voter;
    
    constructor() {
        voter = new Voter();
    }
    
    function isSolved() external view returns (bool) {
        // Gelöst wenn 5 Votes abgegeben wurden
        return voter.votes() == 5;
    }
}