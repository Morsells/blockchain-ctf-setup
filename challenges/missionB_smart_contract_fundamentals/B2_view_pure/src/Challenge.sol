// SPDX-License-Identifier: MIT
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
    }
}

contract Setup {
    ViewPureDemo public demo;
    
    constructor() {
        demo = new ViewPureDemo();
    }
    
    function isSolved() external view returns (bool) {
        return demo.getData() == 42 &&
               demo.getMessageLength() == 10 &&
               demo.add(5, 7) == 12 &&
               keccak256(bytes(demo.concatenate("Hello", "World"))) == keccak256(bytes("HelloWorld"));
    }
}