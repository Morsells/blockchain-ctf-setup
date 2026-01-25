# Mission B Capstone: Sicheren Vault implementieren

## Lernziele
- Sichere Token-Transfers implementieren
- Access Control mit eigenen Modifiern
- Events für Transparenz nutzen
- Überlauf-/Unterlauf-Schutz verstehen
- Testabdeckung sicherstellen

## Aufgabe

Du musst einen sicheren Vault für ERC20-Token implementieren. Der Vault soll folgende Funktionen haben:

1. **Einzahlung**: Token in den Vault einzahlen
2. **Auszahlung**: Nur der Eigentümer kann Token abheben
3. **Balance abfragen**: Aktuelle Balance des Vaults und eines Benutzers
4. **Emergency Stop**: Nur Owner kann bei Problemen alle Funktionen pausieren

## Anforderungen

- Verwende den mitgelieferten `SimpleToken` (ERC20-ähnlich)
- Implementiere alle `TODO` Kommentare in `Solution.sol`
- Die Tests müssen vollständig bestehen
- Verhindere alle bekannten Sicherheitslücken

## Hinweise
- Nutze den `onlyOwner` Modifier für geschützte Funktionen
- Implementiere den `whenNotPaused` Modifier
- Vergiss nicht, Events zu emittieren
- Achte auf SafeMath oder Solidity 0.8.x Overflow-Schutz

## Erfolgskriterium
Wenn alle Tests bestehen, wird die Flag ausgegeben:

`FLAG{mission_B_capstone_secure_vault_solved}`