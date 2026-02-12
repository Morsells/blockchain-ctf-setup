<<<<<<< HEAD
## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
=======
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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
