// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract PayoutVault {
    mapping(address => uint256) public credits;

    function depositFor(address user) external payable {
        credits[user] += msg.value;
    }

    function withdraw() external {
        uint256 amount = credits[msg.sender];
        require(amount > 0, "no credit");

        // BUG: externe Auszahlung passiert vor dem Update -> reentrancy möglich
        (bool ok,) = payable(msg.sender).call{value: amount}("");
        require(ok, "send failed");

        credits[msg.sender] = 0;
    }

    receive() external payable {}
}

contract Setup {
    PayoutVault public vault;

    uint256 public constant TREASURY = 1 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 1 ether");
        vault = new PayoutVault();
        vault.depositFor{value: TREASURY}(address(this));
    }

    function isSolved(address player) external view returns (bool) {
        return address(vault).balance == 0 && player.balance >= TREASURY;
    }
}