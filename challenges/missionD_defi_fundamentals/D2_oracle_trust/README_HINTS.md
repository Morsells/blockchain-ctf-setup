# D2 - Hints

## Hint 1
The oracle is not robust here; it mirrors AMM spot price after `update()`.

## Hint 2
`swapBforA` pushes A price up in B terms.

## Hint 3 (strong)
Perform one or more large `swapBforA(...)` trades, then call `oracle.update()`.
You need the updated oracle price to be significantly above the start value.
