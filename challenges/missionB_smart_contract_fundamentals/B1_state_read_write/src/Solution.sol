// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        Counter counter = setup.counter();
        
        // TODO: Setze den Counter auf 100
        // Tipp: Verwende die setCounter() Funktion
        
        // TODO: Überprüfe dass der Counter korrekt gesetzt wurde
        // Tipp: Verwende die getCounter() Funktion
    }
}