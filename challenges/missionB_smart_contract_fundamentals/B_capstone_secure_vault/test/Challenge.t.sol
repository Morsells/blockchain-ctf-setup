// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/SimpleToken.sol";
import "../src/Challenge.sol";

contract ChallengeTest is Test {
    SimpleToken public token;
    SecureVault public vault;
    
    address owner = address(0x1);
    address user1 = address(0x2);
    address user2 = address(0x3);
    
    uint256 constant INITIAL_SUPPLY = 1000 ether;
    
    function setUp() public {
        vm.startPrank(owner);
        token = new SimpleToken(INITIAL_SUPPLY);
        vault = new SecureVault(address(token));
        vm.stopPrank();
        
        // Gebe Token an User
        vm.prank(owner);
        token.transfer(user1, 100 ether);
        
        vm.prank(owner);
        token.transfer(user2, 100 ether);
    }
    
    function test_initialState() public {
        assertEq(vault.owner(), owner, "Owner should be set");
        assertEq(address(vault.token()), address(token), "Token should be set");
        assertEq(vault.paused(), false, "Should not be paused initially");
        assertEq(vault.getVaultBalance(), 0, "Vault should be empty initially");
    }
    
    function test_deposit() public {
        vm.startPrank(user1);
        
        // Approve Vault to spend tokens
        token.approve(address(vault), 50 ether);
        
        // Deposit tokens
        vault.deposit(50 ether);
        
        // Check balances
        assertEq(token.balanceOf(user1), 50 ether, "User1 should have 50 tokens left");
        assertEq(token.balanceOf(address(vault)), 50 ether, "Vault should have 50 tokens");
        assertEq(vault.getUserBalance(user1), 50 ether, "Vault should record 50 tokens for user1");
        assertEq(vault.getVaultBalance(), 50 ether, "Total vault balance should be 50");
        
        vm.stopPrank();
    }
    
    function test_deposit_zeroAmount() public {
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        
        vm.expectRevert("Amount must be greater than 0");
        vault.deposit(0);
        
        vm.stopPrank();
    }
    
    function test_deposit_insufficientAllowance() public {
        vm.startPrank(user1);
        
        // No approval given
        vm.expectRevert("Insufficient allowance");
        vault.deposit(50 ether);
        
        vm.stopPrank();
    }
    
    function test_withdraw_byOwner() public {
        // Setup: user1 deposits
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether);
        vm.stopPrank();
        
        // Withdraw by owner
        vm.prank(owner);
        vault.withdraw(30 ether);
        
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY - 200 ether + 30 ether, "Owner should receive tokens");
        assertEq(token.balanceOf(address(vault)), 20 ether, "Vault should have 20 tokens left");
        assertEq(vault.getVaultBalance(), 20 ether, "Vault balance should be 20");
    }
    
    function test_withdraw_notOwner() public {
        // Setup
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether);
        vm.stopPrank();
        
        // Try to withdraw as non-owner
        vm.prank(user1);
        vm.expectRevert("Not owner");
        vault.withdraw(10 ether);
    }
    
    function test_withdraw_insufficientBalance() public {
        // Setup
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether);
        vm.stopPrank();
        
        // Try to withdraw more than available
        vm.prank(owner);
        vm.expectRevert("Insufficient vault balance");
        vault.withdraw(100 ether);
    }
    
    function test_pause_unpause() public {
        // Pause as owner
        vm.prank(owner);
        vault.pause();
        
        assertEq(vault.paused(), true, "Should be paused");
        
        // Try to deposit while paused
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vm.expectRevert("Contract paused");
        vault.deposit(10 ether);
        vm.stopPrank();
        
        // Unpause
        vm.prank(owner);
        vault.unpause();
        
        assertEq(vault.paused(), false, "Should be unpaused");
        
        // Now deposit should work
        vm.startPrank(user1);
        vault.deposit(10 ether);
        vm.stopPrank();
    }
    
    function test_pause_notOwner() public {
        vm.prank(user1);
        vm.expectRevert("Not owner");
        vault.pause();
    }
    
    function test_unpause_notOwner() public {
        // First pause as owner
        vm.prank(owner);
        vault.pause();
        
        // Try to unpause as non-owner
        vm.prank(user1);
        vm.expectRevert("Not owner");
        vault.unpause();
    }
    
    function test_multipleUsers() public {
        // User1 deposits
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether);
        vm.stopPrank();
        
        // User2 deposits
        vm.startPrank(user2);
        token.approve(address(vault), 30 ether);
        vault.deposit(30 ether);
        vm.stopPrank();
        
        assertEq(vault.getUserBalance(user1), 50 ether, "User1 should have 50");
        assertEq(vault.getUserBalance(user2), 30 ether, "User2 should have 30");
        assertEq(vault.getVaultBalance(), 80 ether, "Total should be 80");
        assertEq(token.balanceOf(address(vault)), 80 ether, "Vault token balance should be 80");
    }
    
    function test_completeChallenge() public {
        // Simuliere kompletten Workflow
        vm.startPrank(user1);
        token.approve(address(vault), 50 ether);
        vault.deposit(50 ether);
        vm.stopPrank();
        
        vm.startPrank(user2);
        token.approve(address(vault), 30 ether);
        vault.deposit(30 ether);
        vm.stopPrank();
        
        vm.prank(owner);
        vault.pause();
        
        vm.prank(owner);
        vault.unpause();
        
        vm.prank(owner);
        vault.withdraw(40 ether);
        
        // Final checks
        assertEq(vault.getVaultBalance(), 40 ether, "Final vault balance should be 40");
        assertEq(vault.getUserBalance(user1), 50 ether, "User1 balance should still be 50");
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY - 200 ether + 40 ether, "Owner should have received 40");
        
        // Erfolg! Gebe Flag aus
        emit log_string("FLAG{mission_B_capstone_secure_vault_solved}");
    }
}