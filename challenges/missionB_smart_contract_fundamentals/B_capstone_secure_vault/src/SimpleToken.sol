// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

/**
 * @title SimpleToken
 * @dev Ein einfacher ERC20-ähnlicher Token für die Challenge
 */
contract SimpleToken {
    string public constant name = "SimpleToken";
    string public constant symbol = "STK";
    uint8 public constant decimals = 18;
    
    uint256 public totalSupply;
    address public owner;
    
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    constructor(uint256 initialSupply) {
        owner = msg.sender;
        totalSupply = initialSupply;
        _balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    
    function transfer(address to, uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    function approve(address spender, uint256 amount) public returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    function allowance(address ownerAddr, address spender) public view returns (uint256) {
        return _allowances[ownerAddr][spender];
    }
    
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][msg.sender] >= amount, "Insufficient allowance");
        
        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        
        emit Transfer(from, to, amount);
        return true;
    }
    
    // Nur für Testzwecke: Erstelle neue Tokens
    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only owner can mint");
        totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
}