// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleBank {
    mapping(address => uint256) public balances;
    
    function deposit() external payable {
        require(msg.value > 0, "Must send ether");
        balances[msg.sender] += msg.value;
    }
    
    // BUG: Diese Funktion prüft nicht, ob der Aufrufer das Geld besitzt!
    function withdraw(uint256 amount) external {
        // FEHLER: Es sollte stehen: require(balances[msg.sender] >= amount, "Insufficient balance");
        // Stattdessen prüft es nur den Contract-Balance
        require(address(this).balance >= amount, "Insufficient contract balance");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
    
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}

contract Setup {
    SimpleBank public bank;
    uint256 public constant TREASURY = 1 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 1 ether");
        bank = new SimpleBank();
        // Einzahlen des initialen Ethers
        bank.deposit{value: TREASURY}();
    }

    function isSolved(address player) external view returns (bool) {
        // Gelöst wenn:
        // 1. Der Bank-Contract leer ist
        // 2. Der Spieler mindestens 1 ETH hat
        return address(bank).balance == 0 && player.balance >= TREASURY;
    }
}