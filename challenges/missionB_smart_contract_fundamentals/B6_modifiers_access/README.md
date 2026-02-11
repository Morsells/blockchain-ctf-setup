# Mission B6: Modifier und Access Control

## Lernziele
- Eigene Modifier erstellen und verwenden
- Access Control Patterns (onlyOwner, whenNotPaused)
- Wiederverwendbare Prüfungen

## Aufgabe
Der `SecureVault` Contract hat einen Modifier-Bug: Der `onlyOwner` Modifier
ist inkorrekt implementiert und erlaubt es jedem, owner-spezifische Funktionen aufzurufen.

Deine Aufgabe: Implementiere die `Solution.sol` um:
1. Den Bug im Modifier auszunutzen
2. Den Vault zu leeren

## Hints
- Modifier sind wiederverwendbare Code-Blöcke
- `_` ist der Platzhalter für den Funktionscode
- Falsche Modifier-Implementierungen können Sicherheitslücken verursachen

## Erfolgskriterium
Wenn der Vault leer ist und du den Ether erhalten hast.
Flag: `FLAG{mission_B6_modifiers_access_solved}`