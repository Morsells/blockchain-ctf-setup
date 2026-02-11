// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Logger {
    event ActionLogged(address indexed user, string message);
    event AdminAction(address indexed admin, string action);
    
    address public admin;
    bool public systemActive = true;
    
    constructor() {
        admin = msg.sender;
    }
    
    // BUG: Event wird VOR der require-Prüfung emittiert!
    function logAction(string memory message) external {
        emit ActionLogged(msg.sender, message); // Event zu früh!
        require(systemActive, "System inactive");
        // Eigentliche Logik hier...
    }
    
    function adminLog(string memory action) external {
        require(msg.sender == admin, "Not admin");
        emit AdminAction(msg.sender, action);
    }
    
    function toggleSystem() external {
        require(msg.sender == admin, "Not admin");
        systemActive = !systemActive;
    }
}

contract Setup {
    Logger public logger;
    
    constructor() {
        logger = new Logger();
    }
    
    function isSolved() external view returns (bool) {
        // Für diesen Test prüfen wir einfach, ob das System aktiv ist
        // In der Realität würde man Events über einen Event-Listener prüfen
        return logger.systemActive() == false;
    }
}