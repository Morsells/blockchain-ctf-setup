// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Player {
    function solve(Setup setup) external payable {
        // TODO: Implement the exploit.
        // Goal: drain the vault and end with >= 1 ether on msg.sender.
        // Hint: msg.sender inside the vault is THIS contract when you call from here.
    }
}