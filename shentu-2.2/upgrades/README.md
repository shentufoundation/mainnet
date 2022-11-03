# Shentu-v230 Upgrade

There is a planned upgrade on shentu-2.2 network at height 6334000, which approximately correspond to `Jan 20, 2022 00:30 UTC`. The upgrade is a simple binary swap:

 1. Stop the running certik daemon
 2. Replace the binary with the ~~v2.3.0~~ v2.3.1 version.
 3. Start the daemon with the new binary.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: ~~https://github.com/ShentuChain/shentu/releases/tag/v2.3.0~~ https://github.com/ShentuChain/shentu/releases/tag/v2.3.1.

### (Optional)

To automate your upgrade process, you can use [cosmovisor](https://docs.cosmos.network/master/run-node/cosmovisor.html). However, we encourage monitoring the process during the time of the actual upgrade to ensure the node upgrades in a timely manner.

# Shentu-v231 Upgrade

There is a planned upgrade on shentu-2.2 network at height 6530000, which approximately correspond to `Feb 02, 2022 16:00 UTC`. The upgrade is a simple binary swap at any height before the upgrade:

 1. Stop the binary at any height before 6530000.
 2. Replace the binary with the v2.3.1 version.
 3. Start the daemon with the new binary.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.3.1.

# Shield-V2 Upgrade

There is a planned upgrade on shentu-2.2 network at height 8705500, which approximately correspond to `July 07, 2022 06:00 UCT`. The upgrade is a simple binary swap <b>at the upgrade height.</b>

 1. Upgrade height is reached
 2. Stop the running certik daemon
 3. Replace the running binary (either v2.3.2 or v2.3.1) to v2.4.0 binary
 4. Start the daemon with the new binary

Or you could use cosmovisor. Shentu-V2 upgrade will support audo-download of the binaries for linux-amd64 binaries.
However, we strongly encourage the node operators to stand by during the upgrade time to ensure the node can be upgrade in a timely manner.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.4.0.

# Shentu-V260 Upgrade

There is a planned upgrade on shentu-2.2 network at height 10485430, which approximately correspond to `Nov 09, 2022 06:00 UCT`. The upgrade is a simple binary swap <b>at the upgrade height.</b> and rename of home directory from .certik to .shentud.

 1. Upgrade height is reached
 2. Stop the running certik daemon
 3. Replace the running binary with the v2.6.0 version. The binary is renamed to shentud since v2.6.0.
 4. <b>Update the home directory (default directory changed from ~/.certik to ~/.shentud)</b>
 5. Start the shentud daemon with the new binary

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all`, `shentud unsafe-reset-all`, or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

<b>Cosmovisor might not be able to find the expected binary or home directory due to the rename from certik to shentud. To make it work, you need to wait for the halt of the certik binary, then set everything up with shentud before you start cosmovisor.</b>

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.6.0.
