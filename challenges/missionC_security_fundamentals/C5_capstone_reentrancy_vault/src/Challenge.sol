// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract RewardVault {
    mapping(address => uint256) public balances;
    mapping(address => bool) public rewardClaimed;

    uint256 public constant REWARD = 0.25 ether;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "no balance");

        bool eligible = !rewardClaimed[msg.sender];

        // 1) Auszahlung (VULN: State wird erst später angepasst)
        (bool ok,) = payable(msg.sender).call{value: amount}("");
        require(ok, "send failed");

        // 2) Bonus/Reward (VULN: eligible wurde am Anfang gecached,
        //    rewardClaimed wird erst später gesetzt)
        if (eligible && address(this).balance >= REWARD) {
            (bool okR,) = payable(msg.sender).call{value: REWARD}("");
            // IMPORTANT: niemals revertieren, sonst wird der Capstone am Ende "undrainbar"
            okR; // ignore
        }

        // 3) Updates zu spät
        balances[msg.sender] = 0;
        if (eligible) rewardClaimed[msg.sender] = true;
    }

    receive() external payable {}
}

contract Setup {
    RewardVault public vault;
    uint256 public constant TREASURY = 2 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 2 ether");
        vault = new RewardVault();
        (bool ok,) = address(vault).call{value: TREASURY}("");
        require(ok, "funding failed");
    }

    function isSolved(address player) external view returns (bool) {
        return address(vault).balance == 0 && player.balance >= TREASURY;
    }
}