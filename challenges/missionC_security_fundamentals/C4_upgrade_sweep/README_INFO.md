# C4 — Info

## What is where?
- `src/Challenge.sol`: proxy + logic contracts + `Setup`.
- `src/Player.sol`: exploit code you implement (PLAYER_TODO pack).
- `src/Solution.sol`: reference exploit (solved pack / prototype).

## Packs
- `C4_upgrade_sweep_PLAYER_TODO.zip`: student version (Player.sol is TODO).
- `C4_upgrade_sweep_player_pack.zip`: solved/reference version.

## High-level idea
The proxy forwards calls via `delegatecall` to the current implementation.  
Because `delegatecall` writes into the proxy’s storage, a storage collision can overwrite `SimpleProxy.admin`.  
Once you control `admin`, you can call `upgradeTo(...)` and switch to `LogicV2`.  
After that, call `sweep(...)` through the proxy to drain the treasury.