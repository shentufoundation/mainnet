# Shentu-2.2

This is a direct chain fork from `shentu-2.1` to `shentu-2.2` network without a binary upgrade.

## Validators should download the [v2.2.0 binary](https://github.com/certikfoundation/shentu/releases/tag/v2.2.0)

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
    
    seeds = "b3192e1ab0cbb9f439b15c82605379018d96b4f2@3.209.12.186:26656,23419a3d9deedabce1a3cbfa0d1a3e55ef2364a7@34.229.203.57:26656"
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
    
