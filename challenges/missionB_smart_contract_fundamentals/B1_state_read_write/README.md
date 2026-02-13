### B1 - State Read & Write

## Goal:
Understand how smart contracts store and modify state variables.
You must correctly implement a persistent counter that can be incremented and read without accidentally modifying state in view functions.

## The contract must:

- Start with value 0

- Increase when increment() is called
- Be readable via counter() and getCounter()
- Not modify state inside view functions
- Mark the setup as solved after 5 increments

## Run
forge test -vvv

## Success
Test prints:
FLAG{mission_B1_state_read_write_solved}
