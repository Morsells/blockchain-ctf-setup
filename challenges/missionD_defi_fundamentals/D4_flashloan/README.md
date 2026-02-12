# D4 - Flashloan Flow

## Goal
- Use a flashloan to manipulate AMM/oracle state and borrow profitably.
- Repay flashloan plus fee in the same transaction.
- Keep positive profit after repayment.

## Rules
- Do not modify `src/Challenge.sol` or protocol contracts in `src/`.
- Implement your logic only in `src/Player.sol`.
- Do not change the assertions in `test/Challenge.t.sol`.

## How to run
forge test
