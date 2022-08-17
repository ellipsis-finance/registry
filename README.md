# registry
Ellipsis pool registry. Based on the [Curve registry](https://github.com/curvefi/curve-pool-registry).

## Deployment Addresses

Contracts are deployed to the BSC mainnet at the following addresses:

* `AddressProvider`: [`0x31D236483A15F9B9dD60b36D4013D75e9dbF852b`](https://bscscan.com/address/0x31D236483A15F9B9dD60b36D4013D75e9dbF852b#code)
* `MetaRegistry`: [`0x3E15311B75656342a3Ade8C46F8D6c60bFa41009`](https://bscscan.com/address/0x3E15311B75656342a3Ade8C46F8D6c60bFa41009#code)
* `Exchanger`: [`0xC0cD22471F7E923b10672A98793F68f041f607EB`](https://bscscan.com/address/0xC0cD22471F7E923b10672A98793F68f041f607EB#code)

The `AddressProvider` deployment will never change. Integrators should always query the other contract addresses from the address provider.
