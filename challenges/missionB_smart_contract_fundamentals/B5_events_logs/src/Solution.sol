// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        Logger logger = setup.logger();
        
        // TODO: Nutze den Bug in logAction() um ein Event zu emitten
        // obwohl die Aktion eigentlich fehlschlagen sollte
        
        // TODO: Deaktiviere das System mit toggleSystem()
        // Tipp: Du musst erst Admin werden oder den aktuellen Admin nutzen
    }
    
    // Hilfsfunktion um das Event zu triggern
    function triggerEvent(Logger logger, string memory message) external {
        logger.logAction(message);
    }
}