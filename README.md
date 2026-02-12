# Blockchain CTF Setup (CTFd + Forge Challenges)

Dieses Repository liefert eine lokale Blockchain-CTF-Umgebung:

- **CTFd** läuft per Docker auf `localhost:8000`
- **Smart-Contract-Challenges** liegen als einzelne **Forge-Projekte** im Ordner `challenges/`
- Challenges werden lokal mit `forge test` validiert (typisch: bei Erfolg wird eine **FLAG** ausgegeben)

---

## Voraussetzungen

### Docker + Docker Compose
Docker Desktop (Windows/macOS) oder Docker Engine (Linux) inkl. Compose v2.

Check:
```bash
docker --version
docker compose version
```

### Foundry / Forge
Für das Testen der Challenges wird `forge` benötigt.

Check:
```bash
forge --version
```

---

## Quickstart: CTFd starten

CTFd liegt in `tooling/ctfd/`.

Start:
```bash
cd tooling/ctfd
docker compose up -d
```

Öffnen im Browser:
- http://localhost:8000

Stoppen:
```bash
docker compose down
```

Datenpersistenz:
- CTFd speichert lokal in `tooling/ctfd/data/ctfd.db`

---

## Repo-Struktur

- `tooling/ctfd/`  
  Docker-Compose Setup für CTFd (inkl. Redis)

- `challenges/<mission>/<challenge>/`  
  Jede Challenge als eigenes Forge-Projekt (z. B. `src/`, `test/`, `foundry.toml`, README)

- `docs/MISSIONS.md`  
  Übersicht/Index aller Missionen & Challenges

- `docs/ADDING_A_CHALLENGE.md`  
  Anleitung zum Hinzufügen neuer Challenges

- `templates/foundry-challenge-template/`  
  Template zum Erstellen neuer Challenges

---

## Missions & Challenges (Überblick)

Mission A — Fundamentals (`missionA_Fundamentals`)
- A1 — Hashing Basics
- A2 — Signature Recovery
- A3 — Context Binding
- A4 — Nonce & Deadline
- A5 — Signed Transfer
- A-Capstone — Exploit Signed Service

Mission B — Smart Contract Fundamentals (`missionB_smart_contract_fundamentals`)
- B1 — State Read/Write
- B2 — View & Pure
- B3 — Transactions & Calls
- B4 — msg.* Context
- B5 — Events & Logs
- B6 — Modifiers & Access
- B7 — Mappings & Structs
- B-Capstone — Secure Vault

Mission C — Security Fundamentals (`missionC_security_fundamentals`)
- C1 — Access Control
- C2 — Safe External Calls
- C3 — Storage Collision Takeover
- C4 — Upgrade Sweep
- C5 — Capstone: Reentrancy Vault

Mission D — DeFi Fundamentals (`missionD_defi_fundamentals`)
- D1 — AMM Price
- D2 — Oracle Trust
- D3 — Collateral Logic
- D4 — Flashloan
- D-Capstone — DeFi Exploit

> Hinweis: Die vollständige und klickbare Übersicht liegt in `docs/MISSIONS.md`.

---

## Challenge lokal testen (Forge)

Beispiel:
```bash
cd challenges/missionC_security_fundamentals/C2_safe_external_calls
forge test -vvv
```

Typisches Verhalten:
- **ungelöst** → Tests schlagen fehl
- **gelöst** → Tests laufen grün und geben häufig eine **FLAG** aus (z. B. `FLAG{...}`)

---

## Neue Challenge hinzufügen (Kurzablauf)

1) Challenge-Ordner anlegen:
```bash
mkdir -p challenges/<mission>/<challenge>
```

2) Template kopieren:
```bash
cp -r templates/foundry-challenge-template/* challenges/<mission>/<challenge>/
```

3) Anpassen:
- `src/` (Challenge-Code)
- `test/` (Erfolgskriterium + Flag-Ausgabe)
- `README.md` im Challenge-Ordner (Beschreibung/Regeln)

4) Lokal testen:
```bash
forge test -vvv
```

5) In CTFd anlegen:
- Admin-UI → neue Challenge erstellen
- Flag aus den Tests (oder aus eurer Flag-Quelle) als Lösung hinterlegen

Details siehe: `docs/ADDING_A_CHALLENGE.md`.

---

## Player-Pack / TODO-Pack

In vielen Challenge-Ordnern liegen ZIPs, z. B.:
- `*_player_pack.zip` → Paket für Spieler
- `*_PLAYER_TODO.zip` → Variante mit offenen TODOs / ohne fertige Lösung

Wenn ihr das Packaging standardisieren wollt, lohnt sich ein `scripts/`-Ordner, damit ZIPs reproduzierbar gebaut werden.

---

## Troubleshooting

### CTFd startet nicht / Port belegt
- Wenn `8000` belegt ist: Port-Mapping in `tooling/ctfd/docker-compose.yml` ändern (z. B. `8001:8000`)

### Forge-Tests schlagen wegen Dependencies fehl
```bash
git submodule update --init --recursive
```

### CTFd “neu aufsetzen”
```bash
cd tooling/ctfd
docker compose down
docker compose up -d
```

---

## Sicherheitshinweise

Dieses Setup ist für lokale Entwicklung/Demos gedacht:
- Keine Default-Credentials/Secrets öffentlich verwenden
- Für produktive Setups: Reverse Proxy, TLS, sichere Secret-Verwaltung, externe DB, etc.