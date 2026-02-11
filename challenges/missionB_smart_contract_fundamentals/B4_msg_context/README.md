# Mission B4: msg.sender und msg.value

## Lernziele
- Kontext-Variablen `msg.sender`, `msg.value` verstehen
- `payable` Funktionen und Ether-Transfers
- Adressen in Solidity handhaben

## Aufgabe
Der `SimpleBank` Contract erlaubt Ether-Einzahlungen, hat aber ein Sicherheitsproblem:
Die `withdraw()` Funktion prüft nicht, ob der Aufrufer der Besitzer des Geldes ist.

Deine Aufgabe: Implementiere die `Solution.sol` um:
1. Ether auf den Contract einzuzahlen
2. Den Sicherheitsbug auszunutzen um Ether abzuheben

## Hints
- `msg.sender`: Adresse des Aufrufers
- `msg.value`: Menge an Ether in wei
- `payable`: Markiert Funktionen die Ether empfangen können
- `address(this).balance`: Balance des Contracts

## Erfolgskriterium
Wenn der Contract leer ist und du mindestens 1 ETH hast, ist die Mission gelöst.
Flag: `FLAG{mission_B4_msg_context_solved}`