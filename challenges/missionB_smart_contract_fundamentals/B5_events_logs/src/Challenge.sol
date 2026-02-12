// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

<<<<<<< HEAD
/*
    CHALLENGE: B5_events_logs

    Learning goals:
    - Understand how events behave on revert
    - Learn why event order matters
    - Understand admin / msg.sender context
*/

contract Logger {
    event ActionLogged(address indexed user, string message);
    event AdminAction(address indexed admin, string action);

    address public admin;
    bool public systemActive = true;

    constructor() {
        admin = msg.sender;
    }

    /*
        BUG:
        The event is emitted BEFORE the require check.
        This allows events to be logged even if the action fails.
    */
    function logAction(string memory message) external {
        // TODO:
        // Why is emitting an event before require() dangerous?
        emit ActionLogged(msg.sender, message);

        require(systemActive, "System inactive");

        // Real logic would be here
    }

=======
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
    
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    function adminLog(string memory action) external {
        require(msg.sender == admin, "Not admin");
        emit AdminAction(msg.sender, action);
    }
<<<<<<< HEAD

=======
    
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    function toggleSystem() external {
        require(msg.sender == admin, "Not admin");
        systemActive = !systemActive;
    }
}

contract Setup {
    Logger public logger;
<<<<<<< HEAD

    constructor() {
        logger = new Logger();
    }

    /*
        The challenge is solved when:
        - the system is inactive
    */
    function isSolved() external view returns (bool) {
        return logger.systemActive() == false;
    }
}
=======
    
    constructor() {
        logger = new Logger();
    }
    
    function isSolved() external view returns (bool) {
        // Für diesen Test prüfen wir einfach, ob das System aktiv ist
        // In der Realität würde man Events über einen Event-Listener prüfen
        return logger.systemActive() == false;
    }
}
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
