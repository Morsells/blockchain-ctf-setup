// SPDX-License-Identifier: MIT
<<<<<<< HEAD
pragma solidity ^0.8.33;

contract ViewPureDemo {
    uint256 public data = 42;
    string public message = "Blockchain";
    
    // ✅ VIEW Funktion - liest State
    function getData() public view returns (uint256) {
        return data;
    }

    // ✅ VIEW Funktion - liest State
    function getMessageLength() public view returns (uint256) {
        return bytes(message).length;
    }

    // ✅ PURE Funktion - nur Parameter
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // ✅ PURE Funktion - nur Parameter
    function concatenate(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
=======
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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }
}

contract Setup {
<<<<<<< HEAD
    ViewPureDemo public demo;
    
    constructor() {
        demo = new ViewPureDemo();
    }
    
    function isSolved() external view returns (bool) {
        return demo.getData() == 42 &&
               demo.getMessageLength() == 10 &&
               demo.add(5, 7) == 12 &&
               keccak256(bytes(demo.concatenate("Hello", "World"))) == keccak256(bytes("HelloWorld"));
=======
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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
    }
}