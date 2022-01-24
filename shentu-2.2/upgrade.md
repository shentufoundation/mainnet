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

There is a planned upgrade on shentu-2.3 network at height 6530000, which approximately correspond to `Feb 02, 2022 16:00 UTC`. The upgrade is a simple binary swap at any height before the upgrade:

 1. Stop the binary at any height before 6530000.
 2. Replace the binary with the v2.3.1 version.
 3. Start the daemon with the new binary.

Make sure you do <b>NOT</b> perform `certik unsafe-reset-all` or delete the data directory, as it will require you to sync from the beginning of shentu-2.2 network. The above steps are sufficient to perform this upgrade.

You can find the release notes and built binaries here: https://github.com/ShentuChain/shentu/releases/tag/v2.3.1.
