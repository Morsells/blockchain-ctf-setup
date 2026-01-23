 Mission C3 – Storage Collision Takeover

## Kontext
Ein Proxy nutzt `delegatecall` zu einer Logic-Implementierung. Dabei schreibt der Code der Logic in den Storage des Proxys.

## Ziel
Übernimm den Proxy-Admin, ohne den Proxy-Code zu verändern.

## Gegebene Contracts
- `SimpleProxy` (speichert `admin` in Slot 0)
- `LogicV1` (speichert `value` in Slot 0)

## Aufgabe
Rufe die Logic-Funktion über den Proxy so auf, dass durch Storage-Kollision `admin == player` wird.

## Testen
Im Repo-Root:
`forge test --match-path "challenges/missionC_security_fundamentals/C3_storage_collision_takeover/test/*.t.sol" -vvv`

## Erfolgskriterium
`Setup.isSolved(player) == true`

## Flag
`FLAG{missionC_C3_storage_collision}`