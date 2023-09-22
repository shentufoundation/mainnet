# Shentu-2.2

### How to get started with state sync with running Node on Mainnet

 1. Download state_sync.sh
    ```
    wget -O state_sync.sh https://raw.githubusercontent.com/ShentuChain/mainnet/main/shentu-2.2/statesync/state_sync.sh 
    ```
 2. Please, Update RPC_ADDR if you want to start your node with different RPC Node. 

 3. Reset your chain-data and start with a following command   
   ```
   $ shentud tendermint unsafe-reset-all
   $ bash state_sync.sh
   ```  
