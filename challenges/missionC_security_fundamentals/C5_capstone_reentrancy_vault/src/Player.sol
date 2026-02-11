// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Player {
    function solve(Setup setup) external payable {
        // TODO:
        // Drain the vault using reentrancy.
        // Important: if you call the vault from this contract, msg.sender inside the vault is THIS contract.
        // Make sure the final ETH ends up in the player EOA (msg.sender of this solve()).
    }
}