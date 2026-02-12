# Mission B5: Events und Logs

## Lernziele
- Events für Transparenz und Off-Chain Monitoring
- `emit` Keyword verwenden
- Indexierte Parameter für effiziente Filterung

## Aufgabe
Der `Logger` Contract protokolliert Aktionen mit Events, hat aber ein Problem:
Die `logAction()` Funktion emittiert Events, selbst wenn die Aktion fehlschlägt.

Deine Aufgabe: Nutze die `Solution.sol` um:
1. Eine erfolgreiche Aktion durchzuführen
2. Das entsprechende Event zu triggern
3. Zu zeigen, dass Events auch bei Reverts nicht zurückgenommen werden

## Hints
- Events werden in Logs gespeichert
- `indexed` Parameter sind filterbar
- Events werden auch bei Reverts nicht "ungeschehen" gemacht
- `emit` löst ein Event aus

## Erfolgskriterium
Wenn ein `ActionLogged` Event mit message "HACKED" ausgelöst wurde.
Flag: `FLAG{mission_B5_events_logs_solved}`