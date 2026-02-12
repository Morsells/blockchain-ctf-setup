# D4 - Hints

## Hint 1
Order matters: flashloan -> manipulate -> deposit collateral -> borrow -> repay.

## Hint 2
Inside `onFlashLoan`, approve token spending for AMM and lending pool.

## Hint 3 (strong)
Borrow B via flashloan, swap B->A, deposit A as collateral, borrow B from pool,
repay flashloan + fee, and keep remaining B as profit.
