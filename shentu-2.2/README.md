# Shentu-2.2

## There are past/planned upgrades for shentu-2.2 networks. To make sure you're up-to-date on the on-chain software upgrades, check [upgrade instructions](https://github.com/ShentuChain/mainnet/blob/main/shentu-2.2/upgrades)

## This network is a direct chain fork from `shentu-2.1` to `shentu-2.2` network without a binary upgrade.

## Latest version download [link](https://github.com/shentufoundation/shentu/releases)

### How to Join Shentu-2.2 Mainnet with snapshot

 1. (Optional) Init shentud
    ```bash
    shentud init <moniker> --chain-id shentu-2.2 --home <your path>
    ```
 2. (Optional) Back up the old chain state.
    ```bash
    mv <your path>/.shentud/data <your path>/.shentud/data_old
    ```
 3. Reset the chain state.
    ```bash
    shentud tendermint unsafe-reset-all --home <your path> --keep-addr-book
    ```
 4. Add the seed nodes in `config/config.toml`.
    ```bash
    seeds = "867a2986f28575b1fde864136862fde465cac17c@47.253.209.134:26656,3edd4e16b791218b623f883d04f8aa5c3ff2cca6@shentu-seed.panthea.eu:36656"
    ```
 5. Download the snapshot.
    ```bash
    wget https://snapshot-light.shentu.org/shentu.tar.gz
    ```
 6. Unzip/Unpack the snapshot into <<your path>> .shentud directory.
 7. Start `shentud` daemon.
    ```bash
    shentud start --home <your path>
    ```
 8. (Optional) Run Shentud daemon as a system service

    save the following content as `shentud.service` under `/etc/systemd/system/`

    ```
    [Unit]
    Description=Shentud Daemon
    After=network-online.target

    [Service]
    User=ubuntu
    ExecStart=<your path>/shentud start --home <your path>/.shentud
    Restart=always
    RestartSec=3
    LimitNOFILE=4096
    [Install]
    WantedBy=multi-user.target
    ```
    remember to replace the `User` to your corresponding username.
    remember to replace the `ExecStart` to your corresponding path.

 9. Enable and start shentud system service.
     ```bash
     sudo systemctl enable shentud
     sudo systemctl start shentud
     ```
 10. Check the shentud log.
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
