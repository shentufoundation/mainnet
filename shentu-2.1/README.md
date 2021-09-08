# Shentu-2.1

## Validators should download the [v2.2.0 binary](https://github.com/certikfoundation/shentu/releases/tag/v2.2.0)

### How to Join Shentu-2.1 Mainnet

 1. Download the new genesis.
    ```bash
    wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/shentu-2.1/genesis.json .
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
    
    seeds = "c8d852d8e5655eb2c2ce5ba7d40b2c4a3a1e8bf1@34.227.117.2:26656,08bfcc3021b10b58fb7148ac4f1541d7f740418a@52.206.223.128:26656,a3432f605de8692acd2a22ba99c6a84eae09a0de@3.89.246.155:26656,1a90d1eb8d91f2ba043e56714345ebfa3f87bad5@34.237.53.195:26656,41e0c490d87266f7c9e78b0e9b0adafd8d06fca5@3.236.161.42:26656,8eb0e830eb7d166a919747c2b9e0d46fe1447802@54.236.61.32:26656,e4f9776fdf1b37bba6d0400092952666820991c7@3.227.241.190:26656,6d808879cbf7420bd525592a0aaf212da7deeb80@34.229.203.57:26656,fb889d51d5b29c3318b719c8e5b23433e6ef4ad9@54.197.5.155:26656,d789e4e53a17100e7951b20dc6144e89ecbc1b3c@34.232.46.41:26656,895226d59d54c5358f4ef9d53dd42e0fcc9267f4@18.206.119.13:26656,d964e4cc4ac0652234a436a4564f3fbba69149e9@3.209.12.186:26656,8c05eb64e292e7349b7c1a5c6a8e8bbea52e8dce@54.224.14.1:26656,3722d59c1e3b7a9d58f79d8c961ec987b2fefb8b@52.91.51.227:26656,9442e29c89d6a683e096d2e42db793ac52aeb57e@100.26.242.20:26656,a8defa5b5a1ca2d0dbceff46e7cb049cbba272b9@3.82.105.31:26656,aee5b4e20a3df08c64ddea56e9cd80d816e8133f@3.238.117.221:26656"
    ```
 6. Start certik daemon.
    
