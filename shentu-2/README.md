<b> Hash of the exported genesis from shentu-1: 3f28ecb8602d1bc5cb64ae58c2f34dc78522d0fe731275c613a08ae40a3ba157 </b>

```bash
jq -S -c -M '' shentu-1-genesis-exported.json| shasum -a 256 
3f28ecb8602d1bc5cb64ae58c2f34dc78522d0fe731275c613a08ae40a3ba157  -
```

<b> Hash of final genesis for shentu-2: 04172c30d9a1f3979af007bceaa1bf3e044e41b845ed6e424a9ed3fb90b1805d </b>

```bash
jq -S -c -M '' genesis.json| shasum -a 256 
04172c30d9a1f3979af007bceaa1bf3e044e41b845ed6e424a9ed3fb90b1805d  -
```

# How to join Shentu-2 Mainnet

## Recommended system setup

Certified TIA-942 Tier 3 or higher
- 4 physical core CPU
- Memory: 8GB
- Disk: 256GB+ 
- Ubuntu 18.04 +

## Node Migration Guidelines

For validators or node runners looking to upgrade their node from shentu-1 to shentu-2, visit [CertiK Chain Shentu-2 Migration Guidelines](https://github.com/certikfoundation/mainnet/blob/main/shentu-2/migration.md).

## Setup Guidelines POST Shentu-2 LAUNCH (Aug/31/2021)

(Optional - create directory)

	mkdir certik
	cd certik

Download the v2.0.0 binary release.
https://github.com/certikfoundation/shentu/releases/tag/v2.0.0

For Linux:
	wget https://github.com/certikfoundation/shentu/releases/download/v2.0.0/certik_2.0.0.0809_linux_amd64
	chmod +x ./certik

Initialize certik daemon - run it, should show you the help but also create the .certik in your home dir.

	./certik

Download the final genesis.

	wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/shentu-2/genesis.json

Copy the final genesis file to your certik config directory.

	cp genesis.json $HOME/.certik/config/genesis.json

Check if you have the correct genesis.

	sha256sum ~/.certik/config/genesis.json

Output should be:	

	dummygenesisshasum  shentu-2/genesis.json

Edit config.toml in the config directory to include the seeds.<br />
seeds = "<seed nodes above separated by comma>" (I use vi, but feel free to use other editors)

	vi ~/.certik/config/config.toml

Add the seeds from the [seed list](https://github.com/certikfoundation/mainnet/blob/main/shentu-2/seeds.txt) to .certik/config/config.toml. <br />
Currently this would result into:

```
seeds = "c8d852d8e5655eb2c2ce5ba7d40b2c4a3a1e8bf1@34.227.117.2:26656,08bfcc3021b10b58fb7148ac4f1541d7f740418a@52.206.223.128:26656,a3432f605de8692acd2a22ba99c6a84eae09a0de@3.89.246.155:26656,1a90d1eb8d91f2ba043e56714345ebfa3f87bad5@34.237.53.195:26656,41e0c490d87266f7c9e78b0e9b0adafd8d06fca5@3.236.161.42:26656,8eb0e830eb7d166a919747c2b9e0d46fe1447802@54.236.61.32:26656,e4f9776fdf1b37bba6d0400092952666820991c7@3.227.241.190:26656,6d808879cbf7420bd525592a0aaf212da7deeb80@34.229.203.57:26656,fb889d51d5b29c3318b719c8e5b23433e6ef4ad9@54.197.5.155:26656,d789e4e53a17100e7951b20dc6144e89ecbc1b3c@34.232.46.41:26656,895226d59d54c5358f4ef9d53dd42e0fcc9267f4@18.206.119.13:26656,d964e4cc4ac0652234a436a4564f3fbba69149e9@3.209.12.186:26656,8c05eb64e292e7349b7c1a5c6a8e8bbea52e8dce@54.224.14.1:26656,3722d59c1e3b7a9d58f79d8c961ec987b2fefb8b@52.91.51.227:26656,9442e29c89d6a683e096d2e42db793ac52aeb57e@100.26.242.20:26656,a8defa5b5a1ca2d0dbceff46e7cb049cbba272b9@3.82.105.31:26656,aee5b4e20a3df08c64ddea56e9cd80d816e8133f@3.238.117.221:26656"
```

Go back to your original directory with the binaries:

	cd ~/certik

Reset certik data through the following command:

	./certik unsafe-reset-all

Start certik daemon.

	./certik start

Let it run for a minute and then kill it.

	use ctrl + c to stop in console
	Or kill the process killall certik

Go to the latest version on github and download the certik binary. (https://github.com/certikfoundation/shentu/releases) <br />
For example:

	wget https://github.com/certikfoundation/shentu/releases/download/v2.0.0/certik_2.0.0.0809_linux_amd64

Update them to correct permissions - change command to correct version. <br />
For example:

	chmod +x certik

Implement the certik as binaries so we can just access it through `certik`. <br />
For example:

	sudo cp certik_2.0.0.0809_linux_amd64 /bin/certik

Start certik and continue the sync. It could be that you get a lot of errors in the start but it should start picking up other.

	certik start.

You can create the wallet through certik now:

	certik keys add <your-wallet-name>

Once certik daemon is synced up to the latest height, <br />
Register your validator - this is using the minimum staked ctk of 1 - here it is up to you to configure as wanted, note this is just an example. <br />
Keep in mind that the minimum staked amount is 1 CTK this is 1000000uctk

	certik tx staking create-validator \
	--amount <your-amount-to-stake>uctk \
	--commission-max-change-rate 0.01 \
	--commission-max-rate 0.2 \
	--commission-rate 0.1 \
	--from <your-wallet-name> \
	--min-self-delegation 1 \
	--moniker <your-moniker> \
	--pubkey $(certik tendermint show-validator) \
	--chain-id shentu-2

### Extra - Starting certik as a service

As an extra you can run certik daemon as a service.

	sudo vi /etc/systemd/system/certik.service

Add following to the file, make sure to change ubuntu to the correct user.

	[Unit]
	Description=CertiK Daemon
	After=network-online.target
	[Service]
	User=ubuntu
	TimeoutStartSec=0
	CPUWeight=90
	IOWeight=90
	ExecStart=/usr/local/bin/certik start
	Restart=always
	RestartSec=3
	LimitNOFILE=65535
	KillSignal=SIGTERM
	StandardOutput=file:/var/log/certik.log
	StandardError=file:/var/log/certik.log
	[Install]
	WantedBy=multi-user.target

Initialize the log file:

	sudo touch /var/log/certik.log

You can start the service like this:

	sudo systemctl enable certik
	sudo systemctl start certik

## Hashes
Hash of the exported genesis from shentu-1: TBD

Hash of final genesis for shentu-2: TBD
