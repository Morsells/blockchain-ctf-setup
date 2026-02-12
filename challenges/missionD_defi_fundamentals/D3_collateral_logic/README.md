# D3 - Collateral Logic

## Goal
- Use manipulated price data to pass collateral checks.
- Borrow more than the normal limit without tripping `require`.

## Rules
- Do not modify `src/Challenge.sol`, `src/LendingPool.sol`, `src/SimpleAMM.sol`, or `src/SimpleOracle.sol`.
- Implement your logic only in `src/Player.sol`.
- Do not change the assertions in `test/Challenge.t.sol`.

## How to run
forge test
