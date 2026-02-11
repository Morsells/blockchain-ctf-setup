# C5 — Info

## What is where?
- `src/Challenge.sol`: the vulnerable `RewardVault` and `Setup` (treasury funding).
- `src/Player.sol`: exploit code you implement (PLAYER_TODO pack).
- `src/Solution.sol`: reference exploit (solved pack / prototype).
- `test/Challenge.t.sol`: Foundry test that checks `Setup.isSolved(player)`.

## Important detail: msg.sender
The vault tracks balances by `msg.sender`.  
If you call the vault from a contract (Player/Solution), then `msg.sender` inside the vault is your contract address — not the EOA.

## Test setup (what the test expects)
The test funds the EOA and then calls the solver with ETH:
- `vm.deal(player, 1 ether)`
- `solver.solve{value: 0.1 ether}(setup)`

So the exploit may use `msg.value` (0.1 ether) as the initial deposit amount.

## Packs
- `C5_capstone_reentrancy_vault_PLAYER_TODO.zip`: student version (Player.sol is TODO).
- `C5_capstone_reentrancy_vault_player_pack.zip`: solved/reference version.

## Switching between player/solution tests
In `test/Challenge.t.sol`, swap:
- import `Solution.sol` ↔ import `Player.sol`
- type `Solution solver` ↔ `Player solver`
- `new Solution()` ↔ `new Player()`