# C2 — Safe External Calls (Offensive)

## Goal
Drain the vault and make `Setup.isSolved(player)` return `true`.

## Rules
- Do not modify `src/Challenge.sol` (this is the target system).
- Implement your exploit in `src/Player.sol` (PLAYER_TODO pack).

## How to run
```bash
forge test