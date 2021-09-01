 # How to migrate account keys from `shentu-1` to `shentu-2`
 
 In shentu-1, we used `certikcli` binary to sign transactions and make transactions. However, since we now have a combined binary `certik`, we have to migrate the eixsting keys from `certikcli` to sign transactions.
 Note you might be prompted to input passwords depending on the keyring you are using.
 
  1. run `certikcli keys list` and see what keys you have. 
  
  ```bash
  $ certikcli keys list --keyring-backend <your_keyring_backend>
    - name: testkey
      type: local
      address: certik10ph4g5er75am94mpccv8m9wmedv32gcumm088c
      pubkey: certikpub1addwnpepqg0ycy8vujq8sr8tzn9nyyqz9qnthme3w84genv26dk2zs6n9k2rvq8anku
      mnemonic: ""
      threshold: 0
  ```
  
  2. Assuming we want to migrate `testkey` to `certik`, run the following command:
  
  ```bash
  $ certikcli keys export testkey
    Enter passphrase to decrypt your key: <decryption_passwd>
    Enter passphrase to encrypt the exported key: <encryption_passwd>
    -----BEGIN TENDERMINT PRIVATE KEY-----
    <content>
    -----END TENDERMINT PRIVATE KEY-----
  ```
  
  3. Copy the entire output content beginning with `----BEGIN TENDERMINT PRIVATE KEY-----` and ending with `-----END TENDERMINT PRIVATE KEY-----` into a file. Running the following command will show similar content.
  
  ```bash
  $ cat mykey.txt
    -----BEGIN TENDERMINT PRIVATE KEY-----
    salt: <some_salt>
    type: secp256k1
    kdf: bcrypt

    <some_hash>
    -----END TENDERMINT PRIVATE KEY-----
  ```
  
  4. Use `certik` binary to import the key.
  
  ```bash
  $ certik keys import <key_name> mykey.txt
  Enter passphrase to decrypt your key: <encryption_passwd>
  ```
  
  5. See the key imported for `certik` binary.
  
  ```bash
  $ certik keys list
    - name: mykey1
      type: local
      address: certik10ph4g5er75am94mpccv8m9wmedv32gcumm088c
      pubkey: certikpub1addwnpepqg0ycy8vujq8sr8tzn9nyyqz9qnthme3w84genv26dk2zs6n9k2rvq8anku
      mnemonic: ""
      threshold: 0
  pubkeys: []
  ```
