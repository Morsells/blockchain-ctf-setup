// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SecureVault {
    address public owner;
    bool public paused;
    
    // BUG: Der Modifier prüft nicht korrekt!
    modifier onlyOwner() {
        // FEHLER: Sollte sein: require(msg.sender == owner, "Not owner");
        // Stattdessen prüft es irgendwas falsches
        require(msg.sender == address(this), "Not owner");
        _;
    }
    
    modifier whenNotPaused() {
        require(!paused, "Paused");
        _;
    }
    
    constructor() payable {
        owner = msg.sender;
        paused = false;
    }
    
    function withdrawAll(address payable to) external onlyOwner whenNotPaused {
        (bool success, ) = to.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
    
    function pause() external onlyOwner {
        paused = true;
    }
    
    function unpause() external onlyOwner {
        paused = false;
    }
    
    // Öffentliche Funktion um den Contract zu pausieren (Bug!)
    function publicPause() external {
        paused = true;
    }
    
    receive() external payable {}
}

contract Setup {
    SecureVault public vault;
    uint256 public constant TREASURY = 1 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 1 ether");
        vault = new SecureVault{value: TREASURY}();
    }

    function isSolved(address player) external view returns (bool) {
        // Gelöst wenn der Vault leer ist
        return address(vault).balance == 0 && player.balance >= TREASURY;
    }
}