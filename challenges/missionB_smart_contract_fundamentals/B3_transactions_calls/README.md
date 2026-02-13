### B4 - Transactions vs Calls

## Goal:
Understand the difference between blockchain transactions and read-only calls and how they affect contract state.
You must implement a counter that updates correctly when users interact with it through real transactions, while read functions simply return stored values.

## The contract must:

- Increase the counter on each transaction
- Store the address of the last caller
- Return stored values through getter functions
- Mark the challenge solved after 3 different transactions

## Run
forge test -vvv

## Success
Test prints:
FLAG{mission_B3_transactions_calls_solved}

## Hints

- Calls simulieren nur, ändern aber keinen State
- Transaktionen kosten Gas und ändern State
- require() Bedingungen werden auch bei Calls geprüft

