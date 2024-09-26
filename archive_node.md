## Building an Archive Node

The current Shentu chain network is shentu-2.2, starting from block height 4602989. Follow these steps to build an archive node with complete historical data.

### Step 1: Build the Node for the Shentu-1 Period

- **Download Archive Data:** Retrieve the archive data [here](https://shentu-archive.oss-eu-west-1.aliyuncs.com/shentu-1.tar.lz4).
- **Download the Shentu-1 Binary:** Get the binary [here](https://github.com/shentufoundation/shentu/releases/tag/v1.3.2.1005).
- **Initialize the Chain Node:** Run the command `${binary} init [moniker] --chain-id shentu-1 --home ${NODE_HOME}`.
- **Extract the Archive Data:** Use the command `lz4 -c -d shentu-1.tar.lz4 | tar -x -C ${NODE_HOME}` to extract the data.
- **Download the Genesis File:** Obtain the genesis file for Shentu-1 and place it in `${NODE_HOME}/config/genesis.json`.
- **Start the Archive Node:** Launch the archive node with `${binary} start --home ${NODE_HOME}`.

Please note that the service will remain at block height 4313500. Due to compatibility issues between the old version of the Tendermint library and the current version, merging with the Shentu-2 node is not possible.
