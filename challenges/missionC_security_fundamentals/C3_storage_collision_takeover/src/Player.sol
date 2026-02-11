// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Player {
    function solve(Setup setup) external {
        // TODO: Take over the proxy admin via a storage collision.
        // Goal: setup.isSolved(msg.sender) must become true.
    }
}