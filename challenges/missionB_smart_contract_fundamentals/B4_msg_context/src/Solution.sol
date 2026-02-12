// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        SimpleBank bank = setup.bank();
        
        // TODO: Hebe den gesamten Ether aus der Bank ab
        // Tipp: Nutze den Bug in der withdraw() Funktion
        
        // TODO: Stelle sicher, dass der Ether an msg.sender geht
    }
}