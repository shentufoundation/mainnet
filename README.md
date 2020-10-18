# CertiK Chain Shentu Mainnet genesis transaction submission guideline

<b>The deadline to submit your gentx is 10/20/2020 13:00 EDT.</b>

CertiK Chain is finally launching soon. If you participated in the validator program (Raise the Stakes), you can now submit your genesis transaction using the genesis file provided.
Please use v0.9-shentu binary for making gentx. https://github.com/certikfoundation/shentu/releases/tag/v0.9-shentu

1. If you do not have `certikd` initialized (haven't run a node before), run the following command to initialize `certikd` data/config directory.
   ```bash
   certikd init --chain-id shentu-1 <your_moniker> 
   ```
1. Copy the initial genesis file to the `certikd` config directory (by default `~/.certikd/config/`).
    ```bash
    wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/config/genesis.json .
    mv genesis.json ~/.certikd/config/genesis.json
    ```
   
2. Create a genesis account through the following command:
    ```bash
    certikd add-genesis-account <address or key name> 2000000uctk --manual --unlocker certik1up7kaqxxvexgrpuxt6y2258qc3dkjdzvyp29v4 --vesting-amount=1000000uctk
   ```
   example:
   ```
   certikd add-genesis-account mykey 1000000uctk --manual --unlocker certik1up7kaqxxvexgrpuxt6y2258qc3dkjdzvyp29v4 --vesting-amount=1000000uctk
    ```
   1. make sure the address/key matches the one you submit with KYC.
3. Make a genesis transaction using the same address, using the following command:
   ```bash
    certikd gentx --amount <self_delegation_amount> \
    --commission-rate <commission_rate> \
    --commission-max-rate <max_rate> \
    --commission-max-change-rate <max_change_rate> \
    --min-self-delegation <self_delegation_parameter> \
    --name <key_name>
   ```
   example:
   ```go
    --amount 900000uctk
    --commission-rate 0.1
    --commission-max-rate 0.2
    --min-self-delegation 1
   ```
   The above command will give your validator 10% commission rate and 20% max rate, with 0.9CTK delegated from your account.
4. To test your gentx is valid, run the following command:
    ```bash
    certikd collect-gentxs
    certikd start
    ```
   1. If your gentx is valid, it will start a single-node chain.
5. Include your gentx file, located in `~/.certikd/config/gentx/gentx-<hash>.json` to gentx/ directory here, and make a pull request to `master` branch to be included in the mainnet final genesis. Please do <b>not</b> change the file name.
    1. Tips on how to create a PR: https://opensource.com/article/19/7/create-pull-request-github
    
Some notes on gentxs:
1. Make sure you place the genesis file in the correct directory while running `certikd gentx`. Otherwise it will result in an invalid gentx.
2. When you submit your gentx through a PR, make sure you include it in the correct directory without changing the file name.
3. If your gentx is invalid, you will have to wait until mainnet goes live to be certified as validator post-genesis. 
4. Most of the invalid gentxs from the validator testnet was due to wrong chain-id, or wrong parameters. Make sure you check your chain-id is shentu-1 in the genesis and you can start a single-node local chain with your gentx.
