### B4 - msg Context (msg.sender & msg.value)

## Goal:
Correctly handle Ether transfers using msg.sender and msg.value.
You must implement a simple bank where users can deposit and withdraw Ether and where balances are tracked per address.

## The contract must:
- Accept ETH deposits
- Credit the sender’s balance
- Allow users to withdraw only their own funds
- Transfer real Ether on withdraw
- Initialize with an existing deposit from the Setup contract
- Become solvable once the bank is empty and the player owns 1 ETH

## Run
forge test -vvv

## Success
Test prints:
FLAG{mission_B4_msg_context_solved}