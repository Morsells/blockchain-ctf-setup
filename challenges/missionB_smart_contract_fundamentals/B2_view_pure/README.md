# Mission B2: view vs. pure Modifier

## Lernziele
- Unterschied zwischen `view` und `pure` verstehen
- Compiler-Erzwingung von Read-Only Funktionen
- Korrekte Modifier-Verwendung

## Aufgabe
Der `Calculator` Contract hat mehrere Funktionen mit falschen Modifiern.
Deine Aufgabe: Implementiere die `Solution.sol` um:
1. Die inkorrekte `add` Funktion korrekt zu nutzen (trotz falschem Modifier)
2. Die korrekten `multiply` und `getValue` Funktionen zu verwenden

## Hints
- `view` Funktionen können State lesen, aber nicht schreiben
- `pure` Funktionen können weder State lesen noch schreiben
- Der Compiler verhindert inkorrekte Modifier-Verwendung

## Erfolgskriterium
Wenn alle Berechnungen korrekt durchgeführt wurden, ist die Mission gelöst.
Flag: `FLAG{mission_B2_view_pure_solved}`