# ChainLearn – Blockchain Learning & Security CTF

ChainLearn ist eine mission-basierte Lern- und CTF-Plattform für Blockchain- und Smart-Contract-Security.  
Statt direkt mit Hacks zu beginnen, führt ChainLearn Nutzer über einen klaren Lernpfad:

1. Grundlagen verstehen (Wallets, Signaturen, Transaktionen)
2. Smart Contracts korrekt implementieren
3. Security-Patterns erkennen und anwenden
4. Capstone-Challenges lösen (Exploit erst ganz am Ende)

Das System basiert auf:
- **CTFd** als Frontend für Challenges, Missionen und Flag-Validierung  
- **Foundry** als technische Engine, die prüft, ob eine Lösung korrekt ist  
- Einem modularen Challenge-Template, das leicht durch Studierende erweitert werden kann  

Ziel des MVP:
Ein funktionierendes Setup mit nur wenigen Beispiel-Challenges, das im BISD-Blockchainkurs später wie ein „Challenge-Baukasten“ erweitert werden kann.

---

## Quickstart

### 1. CTFd starten
```bash
cd tooling/ctfd
docker-compose up
