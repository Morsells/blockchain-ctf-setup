// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract TokenB {
    mapping(address => uint256) public balanceOf;
    function mintForTraining(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }
}
