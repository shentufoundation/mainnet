# v2.3.0 upgrade

There is a planned upgrade on shentu-2.2 network at height 6334000, which approximately correspond to `Jan 20, 2022 00:30 UTC`. The upgrade is a simple binary swap:

 1. Stop the running certik daemon
 2. Replace the binary with the ~~v2.3.0~~ v2.3.1 version.
 3. Start the daemon with the new binary.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: ~~https://github.com/ShentuChain/shentu/releases/tag/v2.3.0~~ https://github.com/ShentuChain/shentu/releases/tag/v2.3.1.

### (Optional)

To automate your upgrade process, you can use [cosmovisor](https://docs.cosmos.network/master/run-node/cosmovisor.html). However, we encourage monitoring the process during the time of the actual upgrade to ensure the node upgrades in a timely manner.

# v2.3.1 upgrade

There is a planned upgrade on shentu-2.2 network at height 6530000, which approximately correspond to `Feb 02, 2022 16:00 UTC`. The upgrade is a simple binary swap at any height before the upgrade:

 1. Stop the binary at any height before 6530000.
 2. Replace the binary with the v2.3.1 version.
 3. Start the daemon with the new binary.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.3.1.

# v2.4.0 upgrade

There is a planned upgrade on shentu-2.2 network at height 8705500, which approximately correspond to `July 07, 2022 06:00 UCT`. The upgrade is a simple binary swap <b>at the upgrade height.</b>

 1. Upgrade height is reached
 2. Stop the running certik daemon
 3. Replace the running binary (either v2.3.2 or v2.3.1) to v2.4.0 binary
 4. Start the daemon with the new binary

Or you could use cosmovisor. Shentu-V2 upgrade will support audo-download of the binaries for linux-amd64 binaries.
However, we strongly encourage the node operators to stand by during the upgrade time to ensure the node can be upgrade in a timely manner.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.4.0.

# v2.6.0 upgrade

There is a planned upgrade on shentu-2.2 network at height 10485430, which approximately correspond to `Nov 09, 2022 06:00 UCT`. Here are what you need to do.

 1. Upgrade height is reached
 2. Stop the running certik daemon
 3. Replace the running binary with the v2.6.0 version. The binary is renamed to shentud since v2.6.0
 4. <b>Update the home directory (default directory changed from ~/.certik to ~/.shentud)</b>
 5. Add additional config entries. [add_config_entries_v260](https://github.com/ShentuChain/mainnet/blob/main/shentu-2.2/add_config_entries_v260) contains diff files that show the additional entries added in app.toml and config.toml. If you want the upgrade to use iavl-fastnode (will impro ve performance) add iavl-disable-fastnode = false in app.toml under [base] before re-starting the node (it might take several hours) 
 6. Set up shentud system service
 7. Start the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all`, `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

<b>Cosmovisor might not be able to find the expected binary or home directory due to the rename from certik to shentud. To make it work, you need to wait for the halt of the certik binary, then set everything up with shentud before you start cosmovisor.</b> Here are some (probably not all) of the things you need to do.

 1. Upgrade height is reached
 2. Stop the running certik daemon
 3. <b>Update the home directory (default directory changed from ~/.certik to ~/.shentud)</b>
 4. Set up cosmovisor directory under ~/.shentud home directory
 5. Set environment variables with shentud binary and ~/.shentud home directory
 6. Start cosmovisor

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.6.0.

# v2.7.0 upgrade

An upgrade is planned for the Shentu mainnet at height `12926000`, which is estimated to be reached around **0am-1am UTC on April 26, 2023**. Here are what you need to do:

 1. Upgrade height is reached
 2. Stop the running shentud daemon
 3. Replace the running binary with the v2.7.0 version
 4. Restart the shentud daemon with the new binary

 Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

 You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.7.0
 
 # v2.7.1 upgrade

Here are what you need to do:

 1. Stop the running shentud daemon
 2. Replace the running binary with the v2.7.1 version
 3. Restart the shentud daemon with the new binary

 Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

 You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.7.1

# v2.7.2 upgrade

An upgrade is planned for the Shentu mainnet at height `14875800`, which is estimated to be reached around **Sep 06, 2023 13:30-14:30 UTC**. Or you could get the upgrade time by visiting https://www.mintscan.io/shentu/blocks/14875800. Here are what you need to do:

 1. Wait until upgrade height is reached
 2. Stop the running shentud daemon
 3. Replace the running binary with the v2.7.2 version
 4. Restart the shentud daemon with the new binary

 Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

 You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.7.2

# v2.8.0 upgrade

Here are what you need to do:

1. Wait until upgrade height is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.8.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.8.0

# v2.9.0 upgrade

Here are what you need to do:

1. Wait until upgrade height is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.9.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.9.0

# v2.10.0 upgrade

Here are what you need to do:

1. Wait until upgrade height is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.10.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.10.0

# v2.11.0 upgrade

An upgrade is planned for the Shentu mainnet at height `19525000`, which is estimated to be reached around 10am UTC on July 23, 2024.

Here are what you need to do:

1. Wait until upgrade height is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.11.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud tendermint unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.11.0

# v2.12.0 upgrade

An upgrade is planned for the Shentu mainnet at height `20949300`, which is estimated to be reached around 12:30PM UTC on Oct 30th, 2024.

Here are what you need to do:

1. Wait until upgrade height is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.12.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud comet unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.12.0


# v2.13.0 upgrade

The upgrade at height [21239900](https://www.mintscan.io/shentu/block/21239900), expected around `Nov 19th, 2024 13:00 UTC`. 

Here are what you need to do:

1. Wait until upgrade height `21239900` is reached
2. Stop the running shentud daemon
3. Replace the running binary with the v2.13.0 version
4. Restart the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `shentud comet unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/shentufoundation/shentu/releases/tag/v2.13.0
