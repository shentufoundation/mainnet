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
    05ad504b28fba000a1d1aff736324c7be886e5aea166f5f2f07614ad76524cca  shentu-1/genesis.json
    ```
2. Edit `config.toml` in the config directory to include the seeds
    ```
    seeds = "<seed nodes above separated by comma>"
    ```
    example:
    ```
    seeds = "bfd878cfb358f28204ca9009c7dc63b723dc6b98@52.91.51.227:26656,95c818abe0e7b72e66903835775d5afa884ee1f0@3.91.105.64:26656,0d0b19bca0f30fbdaadd20f1a38b2ea35305169e@100.26.242.20:26656,a48d2e1def5c705b31d77651cd18df0a1aded9b8@3.82.105.31:26656,ff0f27a5db14928ab12059069702689dff1bc6d7@3.238.117.221:26656"
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

## After syncing

1. Download v1.1.0 binary release
    1. https://github.com/certikfoundation/shentu/releases/tag/v1.1.0
2. Before height 348000, kill certikd process, and restart (NOT history reset) with the new binary.
3. Note you have to start syncing with v1.0.0 binary, due to app hash difference when loading the genesis.