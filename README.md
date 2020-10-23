## How to join Shentu Mainnet

1. Download the latest binary release
    1. https://github.com/certikfoundation/shentu/releases/tag/v1.0.0
1. Download the final genesis
    ```bash
    wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/shentu-1/genesis.json .
    ```
1. Copy the final genesis file to your certikd config directory
    ```
    $ cp genesis.json $HOME/.certikd/config/genesis.json
    ```
    Check if you have the correct genesis
    ```
    $ sha256sum ~/.certikd/config/genesis.json
    0e58f79c67379e686644960afd4cd2642269ad62ae7a09b516f026b846dd5ad7  /home/ubuntu/.certikd/config/genesis.json
    ```
2. Edit `config.toml` in the config directory to include the seeds
    ```
    seeds = "<seed nodes above separated by comma>"
    ```
    example:
    ```
    seeds = "fb6c1ac01ff8f936eb44e1cae776485371a1f13d@54.82.98.158:26656,b9aa84401f6d6d6d1693b23a60923fe3744ba007@35.153.208.110:26656,ca403870dafd302fb3bfae59946c41c3afdf43c1@3.238.76.49:26656,e19e98be21c63349b0e7249c586236f68efc1467@54.164.253.191:26656,ea4f586396ace26bd5c2c0222073d98b5b196bab@3.238.96.73:26656"
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

<b>
Notes for the node operator (including validators):

1. Make sure you have the correct priv_validator_key.json file in the config directory. It should be the one that you had in the config/ directory where you made your gentx. Otherwise the chain will not recognize you as a validator.

1. Note that the `genesis_time` in the genesis file is set to `October 24th 14:24 UTC`, which means the chain will not start until that time.
</b>