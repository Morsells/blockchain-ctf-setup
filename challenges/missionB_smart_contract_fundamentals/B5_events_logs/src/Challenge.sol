// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

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

    /*
        The challenge is solved when:
        - the system is inactive
    */
    function isSolved() external view returns (bool) {
        return logger.systemActive() == false;
    }
}
