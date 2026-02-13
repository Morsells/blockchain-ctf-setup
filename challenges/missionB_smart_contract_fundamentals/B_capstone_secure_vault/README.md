### B - Capstone Secure Vault

## Goal:
Implement a token vault that safely stores ERC20 tokens for multiple users while enforcing ownership and pause control.

## The vault must:
- Accept deposits only after approve
- Track balances per user
- Track total vault balance
- Allow only the owner to withdraw
- Support pause / unpause
- Block actions while paused
- Never lose accounting consistency

## Run
forge test -vvv

## Success
Test prints:
FLAG{mission_B_capstone_secure_vault_solved}