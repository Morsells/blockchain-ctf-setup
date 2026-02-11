// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract UserRegistry {
    struct User {
        string name;
        uint256 balance;
        bool isAdmin;
        uint256 createdAt;
    }
    
    mapping(address => User) public users;
    address[] public userAddresses;
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
        // Owner als ersten User anlegen
        users[owner] = User({
            name: "Admin",
            balance: 0,
            isAdmin: true,
            createdAt: block.timestamp
        });
        userAddresses.push(owner);
    }
    
    function register(string memory name) external {
        require(bytes(users[msg.sender].name).length == 0, "Already registered");
        
        users[msg.sender] = User({
            name: name,
            balance: 0,
            isAdmin: false,
            createdAt: block.timestamp
        });
        userAddresses.push(msg.sender);
    }
    
    // BUG: Falsche Struct-Initialisierung!
    function becomeAdmin() external {
        // FEHLER: Die Struct-Properties werden nicht korrekt gesetzt
        // Der letzte Wert (createdAt) wird allen Properties zugewiesen!
        users[msg.sender] = User(
            "Hacker",           // name
            block.timestamp,    // balance (sollte 0 sein!)
            true,               // isAdmin
            block.timestamp     // createdAt
        );
    }
    
    function deposit() external payable {
        require(msg.value > 0, "Must send ether");
        users[msg.sender].balance += msg.value;
    }
    
    function withdraw(uint256 amount) external {
        User storage user = users[msg.sender];
        require(user.balance >= amount, "Insufficient balance");
        require(user.isAdmin, "Only admins can withdraw");
        
        user.balance -= amount;
        payable(msg.sender).transfer(amount);
    }
    
    function getUserCount() external view returns (uint256) {
        return userAddresses.length;
    }
    
    // Hilfsfunktion um User-Daten komplett zu bekommen
    function getUserData(address userAddr) external view returns (
        string memory name,
        uint256 balance,
        bool isAdmin,
        uint256 createdAt
    ) {
        User memory user = users[userAddr];
        return (user.name, user.balance, user.isAdmin, user.createdAt);
    }
    
    receive() external payable {}
}

contract Setup {
    UserRegistry public registry;
    
    constructor() payable {
        registry = new UserRegistry();
        // Einzahlen von 1 ETH für Tests
        registry.deposit{value: 1 ether}();
    }
    
    function isSolved(address player) external view returns (bool) {
        // Gelöst wenn der Spieler Admin ist und Balance > 0 hat
        // Wir verwenden die Hilfsfunktion
        (, uint256 balance, bool isAdmin, ) = registry.getUserData(player);
        return isAdmin && balance > 0;
    }
}