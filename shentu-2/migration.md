# Shentu 1 to Shentu 2 Upgrade Instructions

The following document describes the necessary steps involved that validators and full node operators
must take in order to upgrade from `shentu-1` to `shentu-2`. The CertiK teams
will post an official `shentu-2` genesis file, but it is recommended that validators
execute the following instructions in order to verify the resulting genesis file.

There is a strong social consensus around proposal `Shentu 2 Upgrade Proposal`
on `shentu-1`. Following proposals `PROPOSAL LINKS TBA`.
This indicates that the upgrade procedure should be performed on `<DATE TBD>`.

  - [Summary](#summary)
  - [Migrations](#migrations)
  - [Preliminary](#preliminary)
  - [Major Updates](#major-updates)
  - [Risks](#risks)
  - [Recovery](#recovery)
  - [Upgrade Procedure](#upgrade-procedure)
  - [Guidance for Full Node Operators](#guidance-for-full-node-operators)
  - [Notes for Service Providers](#notes-for-service-providers)
 
# Summary

The shentu-1 will undergo a scheduled upgrade to shentu-2 on `<DATE TBD>`.

The following is a short summary of the upgrade steps:
    1. Stopping the running CertiK v1.4.x instance 
    1. Backing up configs, data, and keys used for running shentu-1
    1. Resetting state to clear the local shentu-1 state
    1. Copying the shentu-2 genesis file to the CertiK config folder (either after migrating an existing shentu-1 genesis export, or downloading the shentu-2 genesis from the mainnet github)
    1. Installing the CertiK v2.x.x release
    1. Starting the CertiK v2.x.x instance to resume the Shentu chain at a height 0.

Specific instructions for validators are available in [Upgrade Procedure](#upgrade-procedure), 
and specific instructions for full node operators are available in [Guidance for Full Node Operators](#guidance-for-full-node-operators).

Upgrade coordination and support for validators will be available on the #validators-verified channel of the [CertiK Discord](https://discord.gg/GMrQ9znehh).

The network upgrade can take the following potential pathways:
1. Happy path: Validator successfully migrates the shentu-1 genesis file to a shentu-2 genesis file, and the validator can successfully start CertiK v2 with the shentu-2 genesis within 1-2 hours of the scheduled upgrade.
1. Not-so-happy path: Validators have trouble migrating the shentu-1 genesis to a shentu-2 genesis, but can obtain the genesis file from the Cosmos mainnet github repo and can successfully start Shentu v2 within 1-2 hours of the scheduled upgrade.  
1. Abort path: In the rare event that the team becomes aware of critical issues, which result in an unsuccessful migration within a few hours, the upgrade will be announced as aborted 
   on the #shentu-mainnet channel of [Discord](https://discord.gg/GMrQ9znehh), and validators will need to resume running shentu-1 network without any updates or changes. 
   A new governance proposal for the upgrade will need to be issued and voted on by the community.

# Migrations

These chapters contains all the migration guides to update your app and modules to Cosmos v0.42 Stargate.

If you’re running a block explorer, wallet, exchange, validator, or any other service (eg. custody provider) that depends upon the CertiK Chain, you’ll want to pay attention, because this upgrade will involve substantial changes.

For some resources that is similar with Cosmos Hub upgrade:
1. [App and Modules Migration](https://github.com/cosmos/cosmos-sdk/blob/master/docs/migrations/app_and_modules.md)
1. [Chain Upgrade Guide to v0.40](https://github.com/cosmos/cosmos-sdk/blob/master/docs/migrations/chain-upgrade-guide-040.md)
1. [REST Endpoints Migration](https://github.com/cosmos/cosmos-sdk/blob/master/docs/migrations/rest.md)
1. [Collection of breaking changes from changelogs](breaking_changes.md)
1. [Inter-Blockchain Communication (IBC)– cross-chain transactions](https://figment.network/resources/cosmos-stargate-upgrade-overview/#ibc)
1. [Protobuf Migration – blockchain performance & dev acceleration](https://figment.network/resources/cosmos-stargate-upgrade-overview/#proto)
1. [State Sync – minutes to sync new nodes](https://figment.network/resources/cosmos-stargate-upgrade-overview/#sync)
1. [Full-Featured Light Clients](https://figment.network/resources/cosmos-stargate-upgrade-overview/#light)
1. [Chain Upgrade Module – upgrade automation](https://figment.network/resources/cosmos-stargate-upgrade-overview/#upgrade)
1. [Keyring Migration Guide](https://docs.cosmos.network/master/migrations/keyring.html)

If you want to test the procedure before the update happens on `TBD`, please see this post accordingly:

https://github.com/cosmos/gaia/issues/569#issuecomment-767910963

## Preliminary

Many changes have occurred to the CertiK application since the the launch of the mainnet (`shentu-1`). These changes notably consist of many new features,
protocol changes, and application structural changes.

First and foremost, [IBC](https://docs.cosmos.network/master/ibc/overview.html) following 
the [Interchain Standads](https://github.com/cosmos/ics#ibc-quick-references) will be enabled. 
This upgrade comes with several improvements in efficiency, node synchronization and following blockchain upgrades.
More details on the [Stargate Website](https://stargate.cosmos.network/).

__[Shentu](https://github.com/certikfoundation/shentu) application v2.x.x is
what full node operators will upgrade to and run in this next major upgrade__.
Following Cosmos SDK version v0.xx.xx and Tendermint v0.xx.x.

Validators should expect that at least 8GB of RAM needs to be provisioned to process the first new block on shentu-2.

## Major Updates

There are many notable features and changes in the Stargate release of the SDK. Many of these
are discussed at a high level 
[here](https://github.com/cosmos/stargate).

Some of the biggest changes to take note on when upgrading as a developer or client are the the following:

- **Protocol Buffers**: Initially the Cosmos SDK used Amino codecs for nearly all encoding and decoding. 
In this version a major upgrade to Protocol Buffers have been integrated. It is expected that with Protocol Buffers
applications gain in speed, readability, convinience and interoperability with many programming languages.
[Read more](https://github.com/cosmos/cosmos-sdk/blob/master/docs/migrations/app_and_modules.md#protocol-buffers)
- **CLI**: The CLI and the daemon for a blockchain were seperated in previous versions of the Cosmos SDK. This 
led to a `certikd` and `certikcli` binary which were seperated and could be used for different interactions with the
blockchain. Both of these have been merged into one binary named `certik`.
- **Node Configuration**: Previously blockchain data and node configuration was stored in `~/.certikd/`, these will
now reside in `~/.certik/`, if you use scripts that make use of the configuration or blockchain data, make sure to update the path.

## Risks

As a validator performing the upgrade procedure on your consensus nodes carries a heightened risk of
double-signing and being slashed. The most important piece of this procedure is verifying your
software version and genesis file hash before starting your validator and signing.

The riskiest thing a validator can do is discover that they made a mistake and repeat the upgrade
procedure again during the network startup. If you discover a mistake in the process, the best thing
to do is wait for the network to start before correcting it. If the network is halted and you have
started with a different genesis file than the expected one, seek advice from a CertiK developer
before resetting your validator.

## Recovery

Prior to exporting `shentu-1` state, validators are encouraged to take a full data snapshot at the
export height before proceeding. Snapshotting depends heavily on infrastructure, but generally this
can be done by backing up the `.certikd` directory.

It is critically important to back-up the `.certikd/data/priv_validator_state.json` file after stopping your certikd process. This file is updated every block as your validator participates in a consensus rounds. It is a critical file needed to prevent double-signing, in case the upgrade fails and the previous chain needs to be restarted.

In the event that the upgrade does not succeed, validators and operators must downgrade back to
shentu v1.4.0 with v0.39.1 of the _Cosmos SDK_ and restore to their latest snapshot before restarting their nodes.

## Upgrade Procedure

__Note__: It is assumed you are currently operating a full-node running certik v1.4.0 with v0.39.1 of the _Cosmos SDK_.

The version/commit hash of certik v1.4.0: `331ac5bffc0f8bc3769ff7125f51b871cce58721`

1. Verify you are currently running the correct version (v1.4.0) of _certikd_:

   ```bash
    $ ./certikd version --long
        name: certik
        server_name: certikd
        client_name: certikcli
        version: 1.4.0.0310
        commit: 331ac5bffc0f8bc3769ff7125f51b871cce58721
        build_tags: ""
        go: go version go1.15.6 linux/amd64
   ```

1. Make sure your chain halts at the right block height:
    `TBD`

    ```bash
    perl -i -pe 's/^halt-height =.*/halt-height = TBD/' ~/.certikd/config/app.toml
    ```

 1. After the chain has halted, make a backup of your `.certikd` directory

    ```bash
    mv ~/.certikd ./certikd_backup
    ```

    **NOTE**: It is recommended for validators and operators to take a full data snapshot at the export
   height before proceeding in case the upgrade does not go as planned or if not enough voting power
   comes online in a sufficient and agreed upon amount of time. In such a case, the chain will fallback
   to continue operating `shentu-1`. See [Recovery](#recovery) for details on how to proceed.

1. Export existing state from `shentu-1`:

   Before exporting state via the following command, the `certikd` binary must be stopped!
   Since we know the last block generated in shentu-1, we now export the state.

   ```bash
   $ certikd export --height=<height TBD> > shentu-1-genesis-exported.json
   ```
   _this might take a while, you can expect up to 30 minutes for this step_

1. Verify the SHA256 of the (sorted) exported genesis file:

    Compare this value with other validators / full node operators of the network. 
    Going forward it will be important that all parties can create the same genesis file export.

   ```bash
   $ jq -S -c -M '' shentu-1-genesis-exported.json | shasum -a 256
   [SHA256_VALUE]  shentu-1-genesis-exported.json
   ```

1. At this point you now have a valid exported genesis state! All further steps now require
v2.x.x of [certik](https://github.com/certikfoundation/shentu) binary. 
Cross check your genesis hash with other peers (other validators) in the chat rooms.

   **NOTE**: Go [1.15+](https://golang.org/dl/) is required!

   ```bash
   $ git clone https://github.com/certikfoundation/shentu.git && cd shentu && git checkout v2.x.x; make install
   ```

1. Verify you are currently running the correct version (v2.x.x) of the _CertiK_:

   ```bash
    name: certik
    server_name: certikd
    version: 2.x.x
    commit: dummyshasum6d46572f3273423ad9562cf249a86ecc8206e207
    build_tags: netgo,ledger
    ...
   ```
    The version/commit hash of CertIK v2.x.x: `dummyshasum6d46572f3273423ad9562cf249a86ecc8206e207`

1. Migrate exported state from the current v1.4.0 version to the new v2.x.x version <b>WITH THE v2.x.x BINARY</b>:

   ```bash
   $ certik migrate shentu-1-genesis-exported.json --chain-id=shentu-2 --initial-height 0 > genesis.json
   ```

   This will migrate our exported state into the required `genesis.json` file to start the node in shentu-2.

1. Verify the SHA256 of the final genesis JSON:

   ```bash
   $ jq -S -c -M '' genesis.json | shasum -a 256
   [SHA256_VALUE]  genesis.json
   ```

    Compare this value with other validators / full node operators of the network. 
    It is important that each party can reproduce the same genesis.json file from the steps accordingly.

1. Reset state:

   **NOTE**: Be sure you have a complete backed up state of your node before proceeding with this step.
   See [Recovery](#recovery) for details on how to proceed.

   ```bash
   $ certikd unsafe-reset-all
   ```

1. Move the new `genesis.json` to your `.certik/config/` directory

    ```bash
    cp genesis.json ~/.certik/config/
    ```

1. Start your blockchain 

    ```bash
    certik start
    ```

    Automated audits of the genesis state can take a few seconds using the crisis module. This can be disabled by 
    `certik start --x-crisis-skip-assert-invariants`.

# Guidance for Full Node Operators

1. Verify you are currently running the correct version (v1.4.0) of _certikd_:

   ```bash
    $ ./certikd version --long
        name: certik
        server_name: certikd
        client_name: certikcli
        version: 1.4.0.0310
        commit: 331ac5bffc0f8bc3769ff7125f51b871cce58721
        build_tags: ""
        go: go version go1.15.6 linux/amd64
   ```

1. Stop your certikd v1.4.0 instance.

1. After the chain has halted, make a backup of your `.certikd` directory

   ```bash
   mv ~/.certikd ./certikd_backup
   ```

   **NOTE**: It is recommended for validators and node operators to take a full data snapshot at the export
   height before proceeding in case the upgrade does not go as planned or if not enough voting power
   comes online in a sufficient and agreed upon amount of time. That means the backup of `.certikd` should 
   only take place once the chain has halted at height `height TBD`.
   In such a case, the chain will fallback
   to continue operating `shentu-1`. See [Recovery](#recovery) for details on how to proceed.

1. Download the shentu-2 genesis file from the [Shentu Mainnet Github](https://github.com/shentu/mainnet).
   This file will be generated by a validator that is migrating from shentu-1 to shentu-2.
   The shentu-2 genesis file will be validated by community participants, and
   the hash of the file will be shared on the #validators-verified channel of the [Cosmos Discord](https://discord.gg/vcExX9T).

1. Install v2.x.x of [certik](https://github.com/certikfoundation/shentu).

   **NOTE**: Go [1.15+](https://golang.org/dl/) is required!

   ```bash
   $ git clone https://github.com/certikfoundation/shentu.git && cd shentu && git checkout v2.x.x; make install
   ```

1. Verify you are currently running the correct version (v2.x.x) of the _certik_:

   ```bash
    name: certik
    server_name: certikd
    version: 2.x.x
    commit: dummyshasum6d46572f3273423ad9562cf249a86ecc8206e207
    build_tags: netgo,ledger
    ...
   ```
   
   The version/commit hash of certik v2.x.x: `dummyshasum6d46572f3273423ad9562cf249a86ecc8206e207`

1. Reset state:

   **NOTE**: Be sure you have a complete backed up state of your node before proceeding with this step.
   See [Recovery](#recovery) for details on how to proceed.

   ```bash
   $ certikd unsafe-reset-all
   ```

1. Move the new `genesis.json` to your `.certik/config/` directory

    ```bash
    cp genesis.json ~/.certik/config/
    ```

1. Start your blockchain

    ```bash
    certik start
    ```

   Automated audits of the genesis state can take a few minutes using the crisis module. This can be disabled by
   `certik start --x-crisis-skip-assert-invariants`.
   
## Notes for Service Providers

# REST server

In case you have been running REST server with the command `certikcli rest-server` previously, running this command will not be necessary anymore.
API server is now in-process with daemon and can be enabled/disabled by API configuration in your `.certik/config/app.toml`:

```
[api]
# Enable defines if the API server should be enabled.
enable = false
# Swagger defines if swagger documentation should automatically be registered.
swagger = false
```

`swagger` setting refers to enabling/disabling swagger docs API, i.e, /swagger/ API endpoint.

# gRPC Configuration

gRPC configuration in your `.certik/config/app.toml`

```yaml
[grpc]
# Enable defines if the gRPC server should be enabled.
enable = true
# Address defines the gRPC server address to bind to.
address = "0.0.0.0:9090"
```

# State Sync

State Sync Configuration in your `.certik/config/app.toml`

```yaml
# State sync snapshots allow other nodes to rapidly join the network without replaying historical
# blocks, instead downloading and applying a snapshot of the application state at a given height.
[state-sync]
# snapshot-interval specifies the block interval at which local state sync snapshots are
# taken (0 to disable). Must be a multiple of pruning-keep-every.
snapshot-interval = 0
# snapshot-keep-recent specifies the number of recent snapshots to keep and serve (0 to keep all).
snapshot-keep-recent = 2
```
