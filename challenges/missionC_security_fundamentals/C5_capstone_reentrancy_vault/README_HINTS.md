# C5 — Hints

## Hint 1
`withdrawAll()` sends ETH before it clears `balances[msg.sender]`.

## Hint 2
During `call{value: ...}`, a contract can execute code in `receive()` and call back into the vault (reentrancy).

## Hint 3 (strong)
The vault also tries to pay a bonus reward (`REWARD = 0.25 ether`) before state is updated.  
If you reenter on the reward payout, you can accidentally call `withdrawAll()` when your balance is already 0 and hit `require(amount > 0)`.  
A stable exploit typically reenters only on the main payout and stops once the vault can no longer pay the next withdrawal.