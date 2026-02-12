# Mission B7: Mappings und Structs

## Lernziele
- Complex Data Types: Structs und Mappings
- Gas-Optimierung durch Packing
- Iteration über Mappings (Einschränkungen)

## Aufgabe
Der `UserRegistry` Contract verwaltet User-Data in Structs und Mappings.
Es gibt einen Bug: Die `becomeAdmin()` Funktion erlaubt es jedem, Admin zu werden,
indem sie eine falsche Struct-Initialisierung ausnutzt.

Deine Aufgabe: Implementiere die `Solution.sol` um:
1. Admin-Rechte zu erlangen
2. Alle User-Daten zu lesen

## Hints
- Structs kombinieren verschiedene Datentypen
- Mappings sind effiziente Key-Value Stores
- Falsche Struct-Initialisierung kann zu unerwartetem Verhalten führen

## Erfolgskriterium
Wenn du Admin-Rechte erlangt hast und alle User-Daten lesen kannst.
Flag: `FLAG{mission_B7_mappings_structs_solved}`