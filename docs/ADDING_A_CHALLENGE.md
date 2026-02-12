# Neue Challenge hinzufügen

Dieses Projekt nutzt Foundry für Smart-Contract-Challenges.

## Struktur

Jede Challenge liegt in einem eigenen Ordner unter `challenges/`, z. B.:

- `challenges/missionA_blockchain_fundamentals/A1_wallet_sign/`
- `challenges/missionA_blockchain_fundamentals/A_capstone_verify_tx/`

In jedem Challenge-Ordner:

- `foundry.toml`
- `src/Challenge.sol`    (Vorgabe, Zieldefinition)
- `src/Solution.sol`     (wird vom Spieler angepasst)
- `test/Challenge.t.sol` (prüft, ob die Challenge gelöst ist)
- `README.md`            (Beschreibung der Aufgabe)

## Flag-Mechanik

Die Tests sollen bei Erfolg eine Flag ausgeben, z. B.:

`FLAG{mission_A1_solved}`

Diese Flag wird in CTFd als korrekte Lösung hinterlegt.

## Schritte für eine neue Challenge

1. Ordner unter `challenges/missionX_.../` anlegen
2. Foundry-Projekt kopieren (Template verwenden)
3. `Challenge.sol`, `Solution.sol`, `Challenge.t.sol` anpassen
4. Lokal `forge test` ausführen und prüfen, dass:
   - bei nicht gelöster Aufgabe die Tests fehlschlagen
   - bei korrekter Lösung die Tests bestehen und Flag gedruckt wird
5. Challenge in CTFd anlegen:
   - docker compose up -d
   - ctfd läuft auf localhost:8000
   - Mit Admin anemlden: User: Admin PW: toor
   - Auf challenges navigieren
   - Auf das Plus klicken und die Challenge befüllen.
