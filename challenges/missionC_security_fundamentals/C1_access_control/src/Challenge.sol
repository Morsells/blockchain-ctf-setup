// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract AccessVault {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    // BUG: Diese Funktion sollte eigentlich nur der Owner nutzen dürfen,
    // ist aber komplett ungeschützt.
    function setOwner(address newOwner) external {
        owner = newOwner;
    }

    function withdrawAll(address payable to) external {
        require(msg.sender == owner, "not owner");
        (bool ok,) = to.call{value: address(this).balance}("");
        require(ok, "send failed");
    }

    receive() external payable {}
}

contract Setup {
    AccessVault public vault;

    uint256 public constant TREASURY = 1 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 1 ether");
        vault = new AccessVault{value: TREASURY}();
    }

    function isSolved(address player) external view returns (bool) {
        // gelöst, wenn die Vault leer ist und der Spieler mindestens 1 Ether hat
        return address(vault).balance == 0 && player.balance >= TREASURY;
    }
}