# Shentu-2.2

## There are past/planned upgrades for shentu-2.2 networks. To make sure you're up-to-date on the on-chain software upgrades, check [upgrade instructions](https://github.com/ShentuChain/mainnet/blob/main/shentu-2.2/upgrades)

## This network is a direct chain fork from `shentu-2.1` to `shentu-2.2` network without a binary upgrade.

## Latest version download [address](https://github.com/shentufoundation/shentu/releases)

### How to Join Shentu-2.2 Mainnet with snapshot

 1. Download the new genesis.
    ```bash
    wget https://raw.githubusercontent.com/ShentuChain/mainnet/main/shentu-2.2/genesis.json
    ```
 2. Place the genesis under `.shentud/config`
    ```bash
    mv genesis.json ~/.shentud/config/genesis.json
    ```
 3. (Optional) Back up the old chain state.
    ```bash
    mv ~/.shentud/data ~/.shentud/data_old
    ```
 4. Reset the chain state.
    ```bash
    shentud tendermint unsafe-reset-all
    ```
 5. Add the seed nodes in `config/config.toml`.
    ```bash
    seeds = "bc9bbcae77a09b41417f597965f6fcbb8b280892@52.71.99.85:26656,fd2944af442b18dab4ce50d8e001816a38490d56@54.158.108.97:26656,3edd4e16b791218b623f883d04f8aa5c3ff2cca6@shentu-seed.panthea.eu:36656"
    ```
 6. Download the snapshot.
    ```bash
    wget https://d35kzm6d1vecp9.cloudfront.net/shentu.tar.gz
    ```
 7. Unzip/Unpack the snapshot into your .shentud directory.
 8. Start `shentud` daemon.
 9. (Optional) Run Shentud daemon as a system service

    save the following content as `shentud.service` under `/etc/systemd/system/`

    ```
    [Unit]
    Description=Shentud Daemon
    After=network-online.target

    [Service]
    User=ubuntu
    ExecStart=/home/ubuntu/shentud start --home /home/ubuntu/.shentud
    Restart=always
    RestartSec=3
    LimitNOFILE=4096
    [Install]
    WantedBy=multi-user.target
    ```
    remember to replace the `User` to your corresponding username.
    remember to replace the `ExecStart` to your corresponding path.

 10. Enable and start shentud system service.
     ```bash
     sudo systemctl enable shentud
     sudo systemctl start shentud
     ```
 11. Check the shentud log.
     ```bash
     journalctl -n 20 -u shentud -f
     ```

 #### Note

When building a new validator make sure to use --chain-id shentu-2.2.

Keep in mind that the minimum staked amount is 1 CTK this is 1000000uctk

example:
```
shentud tx staking create-validator \
--amount <your-amount-to-stake>uctk \
--commission-max-change-rate 0.01 \
--commission-max-rate 0.2 \
--commission-rate 0.1 \
--from <your-wallet-name> \
--min-self-delegation 1 \
--moniker <your-moniker> \
--pubkey $(shentud tendermint show-validator) \
--chain-id shentu-2.2 \
--fees 5000uctk
```

## Frequently used commands
1. Unjail validator
 ```
 shentud tx slashing unjail --from <Walletname> --chain-id shentu-2.2
 ```
2. Redeem commission rewards
 ```
 shentud tx distribution withdraw-rewards <Operator Address> --from <Walletname> --commission  --chain-id=shentu-2.2 --fees 10000uctk
 ```
