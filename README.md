# registry
Ellipsis pool registry. Based on the [Curve registry](https://github.com/curvefi/curve-pool-registry).

## Deployment Addresses

Contracts are deployed to the BSC mainnet at the following addresses:

* `AddressProvider`: [`0x31D236483A15F9B9dD60b36D4013D75e9dbF852b`](https://bscscan.com/address/0x31D236483A15F9B9dD60b36D4013D75e9dbF852b#code)
* `Registry`: [`0x266Bb386252347b03C7B6eB37F950f476D7c3E63`](https://bscscan.com/address/0x266Bb386252347b03C7B6eB37F950f476D7c3E63#code)
* `Exchanger`: [`0xC0cD22471F7E923b10672A98793F68f041f607EB`](https://bscscan.com/address/0xC0cD22471F7E923b10672A98793F68f041f607EB#code)

The `AddressProvider` deployment will never change. Integrators should always query the other contract addresses from the address provider.
