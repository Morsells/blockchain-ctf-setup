# Mission C4 – Upgrade & Sweep

## Kontext
Ein Proxy kann seine Implementation upgraden – aber nur der Admin darf das.
Wenn der Admin übernommen wird, wird „Upgrade“ zur Angriffsfläche.

## Ziel
Übernimm den Admin, upgrade auf eine neue Implementation und räume die Treasury leer.

## Gegebene Contracts
- `SimpleProxy` (Admin in Slot 0, Implementation in Slot 1)
- `LogicV1` (Slot-0-Kollision: `value` überschreibt via delegatecall `admin`)
- `LogicV2` (enthält `sweep()` zum Leeren der Proxy-Balance)
- `Setup` lädt 10 Ether in den Proxy

## Aufgabe
Schreibe in `Solution.sol` einen Angriff, der:
1) Admin übernimmt (Storage-Kollision)
2) `upgradeTo()` ausführt
3) `sweep()` ausführt und Ether zum Spieler überweist

## Testen
Im Ordner `C4_upgrade_sweep`:
`forge test -vvv`

## Erfolgskriterium
Proxy-Balance = 0 und Player-Balance >= 10 Ether

## Flag
`FLAG{missionC_C4_upgrade_sweep}`