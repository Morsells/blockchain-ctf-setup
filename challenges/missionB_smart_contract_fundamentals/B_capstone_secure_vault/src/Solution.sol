// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./SimpleToken.sol";
import "./Challenge.sol";

/**
 * @title SecureVault
 * @dev Implementiere einen sicheren Token-Vault
 */
contract SecureVault is IChallenge {
    SimpleToken public immutable token;
    address public owner;
    bool public paused;
    
    mapping(address => uint256) private userBalances;
    uint256 public vaultBalance;
    
    // TODO: Definiere Events für Einzahlung, Auszahlung und Pause
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event Paused(address indexed by);
    event Unpaused(address indexed by);
    
    constructor(address _token) {
        // TODO: Setze owner auf msg.sender und token auf _token
        owner = msg.sender;
        token = SimpleToken(_token);
        paused = false;
    }
    
    // TODO: Implementiere onlyOwner Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    // TODO: Implementiere whenNotPaused Modifier
    modifier whenNotPaused() {
        require(!paused, "Contract paused");
        _;
    }
    
    /**
     * @dev Token in den Vault einzahlen
     * @param amount Anzahl der Token
     * Requirements:
     * - Contract muss unpaused sein
     * - User muss genügend Token haben
     * - User muss dem Contract erlaubt haben, Token zu transferieren
     */
    function deposit(uint256 amount) external whenNotPaused {
        // TODO: Implementiere die Einzahlungslogik
        // 1. Prüfe, dass amount > 0
        // 2. Transferiere Token vom User zum Contract
        // 3. Aktualisiere userBalances und vaultBalance
        // 4. Emitte Event
        require(amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        
        userBalances[msg.sender] += amount;
        vaultBalance += amount;
        
        emit Deposited(msg.sender, amount);
    }
    
    /**
     * @dev Token aus dem Vault abheben
     * @param amount Anzahl der Token
     * Requirements:
     * - Contract muss unpaused sein
     * - Nur der Owner kann abheben
     * - Vault muss genügend Token haben
     */
    function withdraw(uint256 amount) external onlyOwner whenNotPaused {
        // TODO: Implementiere die Auszahlungslogik
        // 1. Prüfe, dass amount > 0
        // 2. Prüfe, dass vaultBalance >= amount
        // 3. Transferiere Token vom Contract zum Owner
        // 4. Aktualisiere vaultBalance (User-Balance bleibt, da nur Owner abheben kann)
        // 5. Emitte Event
        require(amount > 0, "Amount must be greater than 0");
        require(vaultBalance >= amount, "Insufficient vault balance");
        
        vaultBalance -= amount;
        require(token.transfer(owner, amount), "Transfer failed");
        
        emit Withdrawn(msg.sender, amount);
    }
    
    /**
     * @dev Aktuelle Balance des gesamten Vaults
     */
    function getVaultBalance() external view returns (uint256) {
        // TODO: Gib vaultBalance zurück
        return vaultBalance;
    }
    
    /**
     * @dev Balance eines bestimmten Users
     * @param user Adresse des Users
     */
    function getUserBalance(address user) external view returns (uint256) {
        // TODO: Gib userBalances[user] zurück
        return userBalances[user];
    }
    
    /**
     * @dev Pausiere den Contract (nur Owner)
     */
    function pause() external onlyOwner {
        // TODO: Setze paused auf true und emitte Event
        require(!paused, "Already paused");
        paused = true;
        emit Paused(msg.sender);
    }
    
    /**
     * @dev Entpausiere den Contract (nur Owner)
     */
    function unpause() external onlyOwner {
        // TODO: Setze paused auf false und emitte Event
        require(paused, "Not paused");
        paused = false;
        emit Unpaused(msg.sender);
    }
}