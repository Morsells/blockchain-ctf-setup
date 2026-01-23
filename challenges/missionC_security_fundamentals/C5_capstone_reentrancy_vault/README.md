# Mission C5 – Capstone: Reentrancy + Reward-Story

## Kontext
Diese Vault hat eine Bonus-Idee:
Wer zum ersten Mal abhebt, bekommt einmalig einen Reward.
Das klingt harmlos – wird aber gefährlich, wenn die Reihenfolge im Code falsch ist.

## Ziel
Nutze den Fehler so aus, dass du die komplette Vault leer bekommst.

## Gegebene Contracts
- `RewardVault`: Deposit/Withdraw + Bonus-Rewards
- `Setup`: lädt 2 Ether in die Vault und prüft das Erfolgskriterium

## Aufgabe
Schreibe in `Solution.sol` einen Angriff, der:
- eine kleine Einlage macht
- beim Withdraw in einer Schleife wieder reinkommt (Reentrancy)
- dadurch mehr als einmal von der Reward-Logik profitiert
- am Ende die Vault komplett leert

## Testen
Im Ordner `C5_capstone_reentrancy_vault`:
`forge test -vvv`

## Erfolgskriterium
- Vault-Balance = 0
- Player-Balance >= 2 Ether

## Flag
`FLAG{missionC_capstone_reentrancy_reward_vault}`