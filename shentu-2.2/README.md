# Shentu-2.2

## There are past/planned upgrades for shentu-2.2 networks. To make sure you're up-to-date on the on-chain software upgrades, check [upgrade instructions](https://github.com/ShentuChain/mainnet/blob/main/shentu-2.2/upgrades)

## This network is a direct chain fork from `shentu-2.1` to `shentu-2.2` network without a binary upgrade.

## The latest binary version is v2.4.0, which will be used until height 10485430.

## To quickly join the network through state sync snapshot, visit [state sync snapshot guide](https://github.com/ShentuChain/mainnet/edit/main/shentu-2.2/statesync)

### How to Join Shentu-2.2 Mainnet

 1. Download the new genesis.
    ```bash
    wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/shentu-2.2/genesis.json .
    ```
 2. Place the genesis under `.certik/config`
    ```bash
    mv genesis.json ~/.certik/config/genesis.json
    ```
 3. (Optional) Back up the old chain state.
    ```bash
    mv ~/.certik/data ~/.certik/data_old
    ```
 4. Reset the chain state.
    ```bash
    certik unsafe-reset-all
    ```
 5. Add the seed nodes in `config/config.toml`.

    example :
    ```bash
    seeds = "b3192e1ab0cbb9f439b15c82605379018d96b4f2@3.209.12.186:26656,23419a3d9deedabce1a3cbfa0d1a3e55ef2364a7@34.229.203.57:26656,3edd4e16b791218b623f883d04f8aa5c3ff2cca6@shentu-seed.panthea.eu:36656"
    ```
 6. Start certik daemon.

 7. (Optional) Run CertiK daemon as a system service

    save the following content as `certik.service` under `/etc/systemd/system/`

    ```
    [Unit]
    Description=CertiK Daemon
    After=network-online.target

    [Service]
    User=ubuntu
    ExecStart=/home/ubuntu/certik start --home /home/ubuntu/.certik
    Restart=always
    RestartSec=3
    LimitNOFILE=4096
    [Install]
    WantedBy=multi-user.target
    ```
    remember to replace the `User` to your corresponding username.

 8. Enable and start certik system service.
    ```bash
    sudo systemctl enable certik
    sudo systemctl start certik
    ```

 #### Note

When building a new validator make sure to use --chain-id shentu-2.2

example:
```
certik tx staking create-validator \
--amount <your-amount-to-stake>uctk \
--commission-max-change-rate 0.01 \
--commission-max-rate 0.2 \
--commission-rate 0.1 \
--from <your-wallet-name> \
--min-self-delegation 1 \
--moniker <your-moniker> \
--pubkey $(certik tendermint show-validator) \
--chain-id shentu-2.2
```

## Frequently used commands
1. Unjail validator
 ```
 certik tx slashing unjail --from <Walletname> --chain-id shentu-2.2
 ```
2. Redeem commission rewards
 ```
 certik tx distribution withdraw-rewards <Operator Address> --from <Walletname> --commission  --chain-id=shentu-2.2 --fees 10000uctk
 ```
