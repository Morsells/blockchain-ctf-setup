# C2 — Hints

## Hint 1
Look at the order of operations in `withdraw()`.

## Hint 2
What happens if a contract receives ETH and calls back into `withdraw()` before the state is updated?

## Hint 3 (strong)
Deposit a small amount for your exploit contract, call `withdraw()`, and reenter in `receive()` until the vault is empty.