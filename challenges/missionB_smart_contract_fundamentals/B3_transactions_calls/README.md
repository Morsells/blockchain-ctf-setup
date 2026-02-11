# Mission B3: Transaktionen vs. Calls

## Lernziele
- Unterschied zwischen Transaktion (tx) und Call (simulation)
- Wann Gas bezahlt werden muss
- State-Änderungen nur durch Transaktionen

## Aufgabe
Der `Voter` Contract erlaubt Votes, aber die `vote()` Funktion hat ein Problem:
Sie kann durch einfache Calls (Simulation) umgangen werden, ohne Gas zu zahlen.

Deine Aufgabe: Nutze die `Solution.sol` um zu zeigen, dass:
1. Ein Vote als Transaktion durchgeführt wird (State-Änderung)
2. Die Vote-Zählung korrekt funktioniert

## Hints
- Calls simulieren nur, ändern aber keinen State
- Transaktionen kosten Gas und ändern State
- `require()` Bedingungen werden auch bei Calls geprüft

## Erfolgskriterium
Wenn 5 korrekte Votes durchgeführt wurden, ist die Mission gelöst.
Flag: `FLAG{mission_B3_transactions_calls_solved}`