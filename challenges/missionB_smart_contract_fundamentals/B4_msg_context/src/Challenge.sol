// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleBank {
    mapping(address => uint256) public balances;
    
    function deposit() external payable {
        require(msg.value > 0, "Must send ether");
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
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
        bank.deposit{value: TREASURY}();
    }

    receive() external payable {}

    function isSolved(address player) external view returns (bool) {
        return address(bank).balance == 0 && player.balance >= TREASURY;
    }
}