// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// sehr simples Token nur für Training/Tests
contract TokenA {
    mapping(address => uint256) public balanceOf;

    function mintForTraining(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }
}
