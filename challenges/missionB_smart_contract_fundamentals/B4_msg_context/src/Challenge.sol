// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleBank {
    mapping(address => uint256) public balances;
    
    function deposit() external payable {
        require(msg.value > 0, "Must send ether");
        balances[msg.sender] += msg.value;
    }
    
<<<<<<< HEAD
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
=======
    // BUG: Diese Funktion prüft nicht, ob der Aufrufer das Geld besitzt!
    function withdraw(uint256 amount) external {
        // FEHLER: Es sollte stehen: require(balances[msg.sender] >= amount, "Insufficient balance");
        // Stattdessen prüft es nur den Contract-Balance
        require(address(this).balance >= amount, "Insufficient contract balance");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
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
<<<<<<< HEAD
        bank.deposit{value: TREASURY}();
    }

    receive() external payable {}

    function isSolved(address player) external view returns (bool) {
=======
        // Einzahlen des initialen Ethers
        bank.deposit{value: TREASURY}();
    }

    function isSolved(address player) external view returns (bool) {
        // Gelöst wenn:
        // 1. Der Bank-Contract leer ist
        // 2. Der Spieler mindestens 1 ETH hat
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
        return address(bank).balance == 0 && player.balance >= TREASURY;
    }
}