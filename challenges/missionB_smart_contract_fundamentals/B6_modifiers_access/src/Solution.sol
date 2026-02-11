// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        SecureVault vault = setup.vault();
        
        // TODO: Nutze den Bug im onlyOwner Modifier
        // Tipp: Der Modifier prüft msg.sender == address(this)
        // Das bedeutet, der Contract selbst muss die Funktion aufrufen
        
        // TODO: Leere den Vault
    }
    
    // Diese Funktion könnte helfen...
    function attack(SecureVault vault, address payable target) external {
        // Du musst hier die withdrawAll Funktion aufrufen,
        // aber der Modifier erlaubt es nur dem Contract selbst
    }
}