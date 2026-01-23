# Mission C1 – Access Control (Berechtigungen)

## Kontext
Viele Sicherheitsprobleme entstehen nicht durch „kompliziertes Hacking“,
sondern weil eine Funktion nicht richtig abgesichert ist.

## Ziel
Finde heraus, welche Funktion zu viel erlaubt –
und nutze das, um die Vault zu leeren.

## Gegebene Contracts
- `AccessVault`: verwaltet Ether und hat einen `owner`
- `Setup`: lädt 1 Ether in die Vault und prüft das Erfolgskriterium

## Aufgabe
Schaffe es, dass:
1) du die Kontrolle (Owner) übernehmen kannst
2) du danach alles aus der Vault abheben kannst

## Testen
Im Ordner `C1_access_control`:
`forge test -vvv`

## Erfolgskriterium
- Vault-Balance ist 0
- Player hat mindestens 1 Ether

## Flag
`FLAG{missionC_C1_access_control}`