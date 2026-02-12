# C4 — Hints

## Hint 1
The proxy forwards calls using `delegatecall` to the current implementation.

## Hint 2
Under `delegatecall`, the implementation writes into the proxy’s storage layout.

## Hint 3 (strong)
`SimpleProxy.admin` is stored in storage slot 0, and `LogicV1.value` is also slot 0.  
Call `setValue(uint256)` through the proxy to overwrite `admin`, then call `upgradeTo(address)` to switch to `LogicV2`, and finally call `sweep(address)` through the proxy.