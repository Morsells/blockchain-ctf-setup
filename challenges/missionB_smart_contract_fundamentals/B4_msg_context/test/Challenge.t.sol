// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../../../lib/forge-std/src/Test.sol";
import "../src/Challenge.sol";

contract B4MsgContextTest is Test {
    Setup setup;
    SimpleBank bank;
    address player = vm.addr(1);
    address user = vm.addr(2);

    function setUp() public {
        vm.deal(player, 0);
        vm.deal(user, 10 ether);
        
        setup = new Setup{value: 1 ether}();
        bank = setup.bank();
    }

    // ==========================================
    // TEST 1: deposit()
    // ==========================================
    function test_deposit() public {
        vm.prank(user);
        bank.deposit{value: 2 ether}();
        
        assertEq(bank.getBalance(user), 2 ether, "deposit() should increase balance");
        assertEq(address(bank).balance, 1 ether + 2 ether, "Bank should have 3 ether");
    }

    function test_deposit_zero() public {
        vm.prank(user);
        vm.expectRevert("Must send ether");
        bank.deposit{value: 0}();
    }

    // ==========================================
    // TEST 2: withdraw() - NUR EIN WITHDRAW!
    // ==========================================
    function test_withdraw() public {
        vm.prank(user);
        bank.deposit{value: 2 ether}();
        
        uint256 before = user.balance;
        vm.prank(user);
        bank.withdraw(1 ether);
        
        assertEq(bank.getBalance(user), 1 ether, "withdraw() should reduce balance to 1 ether");
        assertEq(user.balance, before + 1 ether, "withdraw() should send 1 ether");
    }

    // ==========================================
    // TEST 3: withdraw twice (separater Test)
    // ==========================================
    function test_withdraw_twice() public {
        vm.prank(user);
        bank.deposit{value: 2 ether}();
        
        vm.prank(user);
        bank.withdraw(1 ether);
        
        uint256 before = user.balance;
        vm.prank(user);
        bank.withdraw(1 ether);
        
        assertEq(bank.getBalance(user), 0 ether, "second withdraw should reduce balance to 0");
        assertEq(user.balance, before + 1 ether, "second withdraw should send 1 ether");
    }

    function test_withdraw_insufficientBalance() public {
        vm.prank(user);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(1 ether);
    }

    // ==========================================
    // TEST 4: getBalance()
    // ==========================================
    function test_getBalance() public {
        vm.prank(user);
        bank.deposit{value: 1.5 ether}();
        
        assertEq(bank.getBalance(user), bank.balances(user), "getBalance() should return balances[user]");
    }

    // ==========================================
    // TEST 5: Constructor
    // ==========================================
    function test_constructor() public {
        assertEq(address(bank).balance, 1 ether, "Bank should have 1 ether initially");
        assertEq(bank.getBalance(address(setup)), 1 ether, "Setup should have 1 ether in bank");
    }

    // ==========================================
    // TEST 6: isSolved()
    // ==========================================
    function test_isSolved() public {
        assertFalse(setup.isSolved(player), "isSolved() should be false (bank has ether)");
        
        // Setup withdraws its deposit
        vm.prank(address(setup));
        bank.withdraw(1 ether);
        
        assertEq(address(bank).balance, 0 ether, "Bank should be empty");
        
        vm.deal(player, 1 ether);
        assertTrue(setup.isSolved(player), "isSolved() should be true when bank empty and player has 1 ether");
    }

    // ==========================================
    // TEST 7: Complete solution with flag
    // ==========================================
function test_complete() public {
    emit log_string("FLAG{mission_B4_msg_context_solved}");
}

}