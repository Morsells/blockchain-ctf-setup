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
>>>>>>> 41154b96b6f5b3d88f00d9d71d8cedd1cb9a0e55
