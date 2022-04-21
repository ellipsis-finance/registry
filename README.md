# registry
Ellipsis pool registry. Based on the [Curve registry](https://github.com/curvefi/curve-pool-registry).

## Deployment Addresses

Contracts are deployed to the BSC mainnet at the following addresses:

* `AddressProvider`: [`0x31D236483A15F9B9dD60b36D4013D75e9dbF852b`](https://bscscan.com/address/0x31D236483A15F9B9dD60b36D4013D75e9dbF852b#code)
* `Registry`: [`0x72b7C17a5B427B59e8b6E8B21C46aA0Fd930Ed01`](https://bscscan.com/address/0x72b7C17a5B427B59e8b6E8B21C46aA0Fd930Ed01#code)
* `Exchanger`: [`0x85FDC3cA0578E2Bc6a358A45c449C92Bea274fa5`](https://bscscan.com/address/0x85FDC3cA0578E2Bc6a358A45c449C92Bea274fa5#code)

The `AddressProvider` deployment will never change. Integrators should always query the other contract addresses from the address provider.
