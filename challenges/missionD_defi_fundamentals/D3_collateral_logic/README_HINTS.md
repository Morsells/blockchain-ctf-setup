# D3 - Hints

## Hint 1
Borrow limit is derived from oracle price and your deposited collateral.

## Hint 2
Raise oracle-dependent price first, then borrow against that inflated valuation.

## Hint 3 (strong)
Deposit A, manipulate AMM price up (B->A side), then borrow B near the new `maxBorrow`.
This can exceed the original safe limit while still passing current checks.
