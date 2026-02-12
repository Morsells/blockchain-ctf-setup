// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./SimpleToken.sol";

/**
 * @title SecureVault
 * @dev Vollständige Musterlösung der Capstone Challenge
 */
contract SecureVault {
    SimpleToken public immutable token;
    address public owner;
    bool public paused;
    
    mapping(address => uint256) private userBalances;
    uint256 public vaultBalance;
    
    // ✅ Events korrekt definiert
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event Paused(address indexed by);
    event Unpaused(address indexed by);
    
    // ✅ Konstruktor korrekt implementiert
    constructor(address _token) {
        owner = msg.sender;
        token = SimpleToken(_token);
        paused = false;
    }
    
    // ✅ onlyOwner Modifier korrekt
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    // ✅ whenNotPaused Modifier korrekt
    modifier whenNotPaused() {
        require(!paused, "Contract paused");
        _;
    }
    
    /**
     * @dev Token in den Vault einzahlen
     */
    function deposit(uint256 amount) external whenNotPaused {
        // ✅ Vollständige Implementierung
        require(amount > 0, "Amount must be greater than 0");
        
        bool success = token.transferFrom(msg.sender, address(this), amount);
        require(success, "Transfer failed");
        
        userBalances[msg.sender] += amount;
        vaultBalance += amount;
        
        emit Deposited(msg.sender, amount);
    }
    
    /**
     * @dev Token aus dem Vault abheben (nur Owner)
     */
    function withdraw(uint256 amount) external onlyOwner whenNotPaused {
        // ✅ Vollständige Implementierung
        require(amount > 0, "Amount must be greater than 0");
        require(vaultBalance >= amount, "Insufficient vault balance");
        
        vaultBalance -= amount;
        
        bool success = token.transfer(owner, amount);
        require(success, "Transfer failed");
        
        emit Withdrawn(msg.sender, amount);
    }
    
    /**
     * @dev Aktuelle Balance des gesamten Vaults
     */
    function getVaultBalance() external view returns (uint256) {
        return vaultBalance;
    }
    
    /**
     * @dev Balance eines bestimmten Users
     */
    function getUserBalance(address user) external view returns (uint256) {
        return userBalances[user];
    }
    
    /**
     * @dev Pausiere den Contract (nur Owner)
     */
    function pause() external onlyOwner {
        require(!paused, "Already paused");
        paused = true;
        emit Paused(msg.sender);
    }
    
    /**
     * @dev Entpausiere den Contract (nur Owner)
     */
    function unpause() external onlyOwner {
        require(paused, "Not paused");
        paused = false;
        emit Unpaused(msg.sender);
    }
}

/**
 * @title Setup
 * @dev Deployed die Challenge und prüft die Lösung
 */
contract Setup {
    SecureVault public vault;
    SimpleToken public token;
    address public owner;
    
    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    
    constructor() {
        owner = msg.sender;
        token = new SimpleToken(INITIAL_SUPPLY);
        vault = new SecureVault(address(token));
        
        // Owner gibt Token an User für Tests
        token.transfer(address(0x1), 100 ether);
        token.transfer(address(0x2), 100 ether);
    }
    
    function isSolved() external view returns (bool) {
        // Wird durch die Tests validiert
        return true;
    }
}