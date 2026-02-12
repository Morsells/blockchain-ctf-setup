# D1 - Hints

## Hint 1
Spot price is the reserve ratio `reserveB / reserveA` scaled by `1e18`.

## Hint 2
For quoting A->B, use the AMM fee-aware formula (or `getAmountOut`).

## Hint 3 (strong)
`effectivePrice` is `out * 1e18 / amountIn`.
For the post-swap price, execute `swapAforB(amountIn)` first, then read the new spot.
