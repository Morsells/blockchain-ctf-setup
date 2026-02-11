# D2 – Oracle & Vertrauen

Kontext:
Ein Oracle speichert nur den letzten Spot-Preis aus dem AMM.

Ziel:
- Zeige, dass der Oracle-Preis durch Trades manipulierbar ist
- Oracle per `update()` auf einen falschen Preis setzen

Run:
forge test -vvv

Success:
FLAG{missionD_D2_oracle_trust}

