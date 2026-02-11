# C3 — Hints

## Hint 1
The proxy uses `delegatecall` to the implementation.

## Hint 2
Under `delegatecall`, the implementation writes into the proxy's storage.

## Hint 3 (strong)
`SimpleProxy.admin` and `LogicV1.value` are both in slot 0. Overwrite slot 0 via a call through the proxy.