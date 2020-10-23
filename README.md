## How to join Shentu Mainnet

1. Download the final genesis
    ```bash
    wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/genesis.json .
    ```
1. Copy the final genesis file to your certikd config directory
    ```
    $ cp genesis.json $HOME/.certikd/config/genesis.json
    ```
    Check if you have the correct genesis
    ```
    $ sha256sum ~/.certikd/config/genesis.json
    90b9a79d4a795e1c8d343480a71578ad60253588  /home/ubuntu/.certikd/config/genesis.json
    ```
2. Edit `config.toml` in the config directory to include the seeds
    ```
    seeds = "<seed nodes above separated by comma>"
    ```
    example:
    ```
    seeds = "7d4a3761d0d725b5522ff00c926b95f36f481aaa@3.235.225.172:26656,e1820e5fd23e43d18be3e3e13a64b9383fb56a81@100.27.49.255:26656,b5ee0d27762dd1f1d4ea4b262b39ebd4ec02e5dc@34.236.38.150:26656,cf24fa8b46e01963f34c2ba885b4f70e2a88a857@3.236.253.202:26656,d70bd3f35a0c1c20e6a8fc57bc46c0ed02e7b381@3.236.144.53:26656"
    ```
3. <b>Reset certikd data through the following command:</b>
    ```
    $ certikd unsafe-reset-all
    ```
    Append `--home <certik_home>` <b>only if</b> your default home directory is NOT `~/.certikd`.
4. Start certikd daemon.
    ```
    $ certikd start
    ```
    Append `--home <certik_home>` <b>only if</b> you default home directory is NOT `~/.certikd`.

Note that the `genesis_time` in the genesis file is set to `October 24th 14:24 UTC`, which means the chain will not start until that time.
