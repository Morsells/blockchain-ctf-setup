# Mission C2 – Safe External Calls

## Kontext
Ein Contract, der Ether auszahlt, kann in Probleme laufen, wenn er erst auszahlt und erst danach seinen Zustand aktualisiert.

## Ziel
Leere die Vault und erhalte mindestens 1 Ether.

## Gegebene Contracts
- `PayoutVault` verwaltet Guthaben pro Adresse
- `Setup` lädt 1 Ether in die Vault

## Aufgabe
Schaffe es, die Vault leer zu bekommen, obwohl du ursprünglich nur einen kleinen Anteil eingezahlt hast.

## Testen
Im Ordner `C2_safe_external_calls`:
`forge test -vvv`

## Erfolgskriterium
Vault-Balance = 0 und Player-Balance >= 1 Ether

## Flag
`FLAG{missionC_C2_safe_external_calls}`