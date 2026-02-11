// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Calculator {
    uint256 public value;
    
    constructor() {
        value = 10;
    }
    
    // BUG: Diese Funktion ist als pure markiert, ändert aber State!
    // Das sollte eigentlich nicht kompilieren, aber wir testen es trotzdem
    function add(uint256 x) external pure returns (uint256) {
        // Eigentlich müsste hier stehen: value += x;
        // Aber als pure kann sie nicht auf value zugreifen
        return x + 5; // Falsche Implementierung
    }
    
    // Korrekte view Funktion
    function getValue() external view returns (uint256) {
        return value;
    }
    
    // Korrekte pure Funktion
    function multiply(uint256 a, uint256 b) external pure returns (uint256) {
        return a * b;
    }
    
    // Ungeschützte set Funktion
    function setValue(uint256 newValue) external {
        value = newValue;
    }
}

contract Setup {
    Calculator public calculator;
    
    constructor() {
        calculator = new Calculator();
    }
    
    function isSolved() external view returns (bool) {
        // Gelöst wenn:
        // 1. value == 100
        // 2. multiply(7, 8) == 56 korrekt berechnet wird
        Calculator calc = calculator;
        return calc.getValue() == 100 && calc.multiply(7, 8) == 56;
    }
}