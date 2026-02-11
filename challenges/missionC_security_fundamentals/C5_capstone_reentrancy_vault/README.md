# C5 — Capstone: Reentrancy Reward Vault (Offensive)

## Goal
Drain the vault and make `Setup.isSolved(player)` return `true`.

The challenge is solved when:
- `address(vault).balance == 0`
- `player.balance >= 2 ether`

## Rules
- Do not modify `src/Challenge.sol` (target system).
- Implement your exploit in `src/Player.sol` (PLAYER_TODO pack).

## How to run
```bash
forge test