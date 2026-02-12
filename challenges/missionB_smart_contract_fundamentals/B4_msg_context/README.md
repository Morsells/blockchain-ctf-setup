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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
