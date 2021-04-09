## REST API CHANGES

First of all, there are a few general notes to keep in mind for this upgrade:

- To enable REST API endpoints, set `enable = true` and `swagger = true` in the file `~/.certik/config/app.toml` before starting the chain. 
- Returned JSONs omit keys when their values are empty.
- GRPC endpoints have been added.
- `POST` endpoints used for generating unsigned transactions have been deprecated. Please take a look at [Cosmos guide](https://github.com/cosmos/cosmos-sdk/blob/master/docs/run-node/txs.md) on generating, signing, and broadcasting transactions.  


The original set of REST endpoints are now called *legacy REST endpoints*, but they have been kept mostly intact in this upgrade. The following table summarizes breaking changes in these endpoints.

| Legacy REST Endpoint                                         | Description                                     | Breaking Change                                              |
| ------------------------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------ |
| `GET /txs/{hash}`                                            | Query tx by hash                                | Endpoint will error when trying to output transactions that don't support Amino serialization (e.g. IBC txs). |
| `GET /txs`                                                   | Query tx by events                              | Endpoint will error when trying to output transactions that don't support Amino serialization (e.g. IBC txs). |
| `GET /auth/accounts/{address}`                               | Query account                                   | Balances are no longer shown in this endpoint. Use `/bank/balances/{address}` instead to query balances. (Properties specfic to vesting account such as `delegated_free`, `delegated_vesting`, `end_time`, and `original_vesting` are still shown in this endpoint.) |
| `GET /cert/certifier/{address}` and `GET /cert/certifiers`   | Query certifiers                                | Field name `certifier` has been changed to `address`.        |
| `GET /cert/certificates` and `GET /cert/certificate/id/{certificate_id}` | Query certificates                              | As a result of the module-wide refactoring, `txhash`, `certificate_type`, and `request_content` fields has been removed. Instead, `content.type` now contains the certificate content and `content.value` the certificate content. Also note that the empty value for `compilation_content` is now an empty object (`{}`) instead of `null`. For more information, see the section Certification Module Refactor. |
| `GET /gov/proposals/{id}/votes`, `GET /gov/proposals/{id}/votes/{voter}` | Gov endpoints for querying votes                | All gov endpoints which return votes return int32 in the `option` field instead of string: `1=VOTE_OPTION_YES, 2=VOTE_OPTION_ABSTAIN, 3=VOTE_OPTION_NO, 4=VOTE_OPTION_NO_WITH_VETO`. |
| `GET /staking/*`, `GET /cert/platform/{pubkey}`              | Staking and cert platform query endpoints       | There is a breaking change for endpoints that return validator consensus public key. The consensus public key field returns an Amino-encoded struct representing an `Any` instead of a bech32-encoded string representing the pubkey. The `value` field of the `Any` is the pubkey's raw key as base64-encoded bytes. |
| `GET /staking/validators`                                    | Get all validators                              | BondStatus parameters are now `?status=BOND_STATUS_{BONDED,UNBONDED,UNBONDING}` as opposed to `?status={bonded,unbonded,unbonding}`. |
| `GET /staking/delegators/{delegatorAddr}/txs`                | Get all staking txs (i.e msgs) from a delegator | Removed                                                      |

