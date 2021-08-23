# Shentu 1 to Shentu 2 Upgrade Instructions

The following document describes the necessary steps involved that validators and full node operators
must take in order to upgrade from `shentu-1` to `shentu-2`. The CertiK teams
will post an official `shentu-2` genesis file, but it is recommended that validators
execute the following instructions in order to verify the resulting genesis file.

There is a strong social consensus around proposal `Shentu 2 Upgrade Proposal`
on `shentu-1`. Following proposals `PROPOSAL LINKS TBA`.
This indicates that the upgrade procedure should be performed on `Aug 31st 2021`.

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

The shentu-1 will undergo a scheduled upgrade at block `4313500`, which corresponds approximately to `Tuesday Aug 31, 2021 at 15:00 UTC` at the current block time (~5.4s/block). Note that the proposed date/time is approximate as blocks are not generated at a constant interval.

- West Coast USA: `7:00 on Aug 31`
- East Coast USA: `10:00 on Aug 31`
- Central Europe: `17:00 on Aug 31`
- Seoul: `00:00 on Sep 1`

The following is a short summary of the upgrade steps:
    1. Stopping the running CertiK v1.4.x instance 
    1. Backing up configs, data, and keys used for running shentu-1
    1. Resetting state to clear the local shentu-1 state
    1. Copying the shentu-2 genesis file to the CertiK config folder (either after migrating an existing shentu-1 genesis export, or downloading the shentu-2 genesis from the mainnet github)
    1. Installing the CertiK v2.0.0 release
    1. Starting the CertiK v2.0.0 instance to resume the Shentu chain at a height 0.

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

If you want to test the procedure before the update happens on `4313500`, please see this post accordingly:

https://github.com/cosmos/gaia/issues/569#issuecomment-767910963

## Preliminary

Many changes have occurred to the CertiK application since the the launch of the mainnet (`shentu-1`). These changes notably consist of many new features,
protocol changes, and application structural changes.

First and foremost, [IBC](https://docs.cosmos.network/master/ibc/overview.html) following 
the [Interchain Standads](https://github.com/cosmos/ics#ibc-quick-references) will be enabled. 
This upgrade comes with several improvements in efficiency, node synchronization and following blockchain upgrades.
More details on the [Stargate Website](https://stargate.cosmos.network/).

__[Shentu](https://github.com/certikfoundation/shentu) application v2.0.0 is
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

## Upgrade Procedure (Without Pre-processed Genesis file)

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
    `4313500`

    ```bash
    perl -i -pe 's/^halt-height =.*/halt-height = 4313500/' ~/.certikd/config/app.toml
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
   $ certikd export --height=4313500 > shentu-1-genesis-exported.json
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
v2.0.0 of [certik](https://github.com/certikfoundation/shentu) binary. 
Cross check your genesis hash with other peers (other validators) in the chat rooms.

   **NOTE**: Go [1.15+](https://golang.org/dl/) is required!

   ```bash
   $ git clone https://github.com/certikfoundation/shentu.git && cd shentu && git checkout v2.0.0; make install
   ```

1. Verify you are currently running the correct version (v2.0.0) of the _CertiK_:

   ```bash
    name: certik
    server_name: certik
    version: 2.0.0
    commit: f4e304d4cd904a5be789e12b12a969582a9c9ccd
    build_tags: netgo,ledger
    ...
   ```
    The version/commit hash of CertIK v2.0.0: `f4e304d4cd904a5be789e12b12a969582a9c9ccd`

1. Migrate exported state from the current v1.4.0 version to the new v2.0.0 version <b>WITH THE v2.0.0 BINARY</b>:

   ```bash
   $ certik migrate shentu-1-genesis-exported.json --chain-id=shentu-2 --initial-height 4313501 > genesis.json
   ```

   This will migrate our exported state into the required `genesis.json` file to start the node in shentu-2.

1. Verify the SHA256 of the final genesis JSON:

   ```bash
   $ jq -S -c -M '' genesis.json | shasum -a 256
   [SHA256_VALUE]  genesis.json
   ```

    Compare this value with other validators / full node operators of the network. 
    It is important that each party can reproduce the same genesis.json file from the steps accordingly.

1. Initialize new `cerik` directory:

    First we want to  initialize the config and data directories <b>using the new binary</b>:
    ```bash
    $ certik init <moniker> --chain-id shentu-2
    ```
    
    Then, copy over the existing validator keys and node keys over to the new directory.
    
    ```bash
    $ cp ~/.certikd/config/priv_validator_key.json ~/.certik/config/
    $ cp ~/.certikd/config/node_key.json ~/.certik/config/
    ```

1. (Optional) Reset old chain data:

   **NOTE**: You will lose all your old chain data if you run this step.

   ```bash
   $ certikd unsafe-reset-all
   ```

1. Supply new chain data into the new chain directory:
    
    Move the new `genesis.json` to your `.certik/config/` directory

    ```bash
    cp genesis.json ~/.certik/config/
    ```
    
    Modify `config.toml` to provide some seed nodes or persistent peers
    
    ```bash
    # Comma separated list of seed nodes to connect to
    seeds = "<node_id@addr:port,...>"
 
    # Comma separated list of nodes to keep persistent connections to
    persistent_peers = "<node_id@addr:port,...>"
    ```
    
    Example:
    ```bash
    seeds = "41e0c490d87266f7c9e78b0e9b0adafd8d06fca5@3.236.161.42:26656,8eb0e830eb7d166a919747c2b9e0d46fe1447802@54.236.61.32:26656,e4f9776fdf1b37bba6d0400092952666820991c7@3.227.241.190:26656,bfd878cfb358f28204ca9009c7dc63b723dc6b98@52.91.51.227:26656,95c818abe0e7b72e66903835775d5afa884ee1f0@54.224.14.1:26656,0d0b19bca0f30fbdaadd20f1a38b2ea35305169e@100.26.242.20:26656,a48d2e1def5c705b31d77651cd18df0a1aded9b8@3.82.105.31:26656,ff0f27a5db14928ab12059069702689dff1bc6d7@3.238.117.221:26656
"
    ```

1. Start your blockchain 

    ```bash
    certik start
    ```

    Automated audits of the genesis state can take a few seconds using the crisis module. This can be disabled by 
    `certik start --x-crisis-skip-assert-invariants`.

# Upgrade Procedure \#2 (With Pre-processed Genesis file)

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
   only take place once the chain has halted at height `4313500`.
   In such a case, the chain will fallback
   to continue operating `shentu-1`. See [Recovery](#recovery) for details on how to proceed.

1. Download the shentu-2 genesis file from the [Shentu Mainnet Github](https://github.com/shentu/mainnet).
   This file will be generated by a validator that is migrating from shentu-1 to shentu-2.
   The shentu-2 genesis file will be validated by community participants, and
   the hash of the file will be shared on the #shentu-mainnet channel of the [CertiK Discord](https://discord.gg/GMrQ9znehh).

1. Install v2.0.0 of [certik](https://github.com/certikfoundation/shentu).

   **NOTE**: Go [1.15+](https://golang.org/dl/) is required!

   ```bash
   $ git clone https://github.com/certikfoundation/shentu.git && cd shentu && git checkout v2.0.0; make install
   ```

1. Verify you are currently running the correct version (v2.0.0) of the _certik_:

   ```bash
   $ certik version --long
    name: certik
    server_name: certik
    version: 2.0.0
    commit: f4e304d4cd904a5be789e12b12a969582a9c9ccd
    build_tags: netgo,ledger
    ...
   ```
   
   The version/commit hash of certik v2.0.0: `f4e304d4cd904a5be789e12b12a969582a9c9ccd`

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
