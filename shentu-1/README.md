# How to join Shentu Mainnet

## Recommended system setup

Certified TIA-942 Tier 3 or higher
- 4 physical core CPU
- Memory: 8GB
- Disk: 500GB+ 
- Ubuntu 18.04 +

## Setup Guidelines

(Optional - create directory) 

	mkdir Certik
	cd Certik

Download the v1.0.0 binary release.
https://github.com/certikfoundation/shentu/releases/tag/v1.0.0

	wget https://github.com/certikfoundation/shentu/releases/download/v1.0.0/certikd_1.0.0.1023_linux_amd64
	chmod +x ./certikd_1.0.0.1023_linux_amd64

Initialize Certikd - run it, should show you the help but also create the .certikd in your home dir.

	./certikd_1.0.0.1023_linux_amd64

Download the final genesis.

	wget https://raw.githubusercontent.com/certikfoundation/mainnet/main/shentu-1/genesis.json

Copy the final genesis file to your certikd config directory.

	cp genesis.json $HOME/.certikd/config/genesis.json

Check if you have the correct genesis.

	sha256sum ~/.certikd/config/genesis.json

Output should be:	

	05ad504b28fba000a1d1aff736324c7be886e5aea166f5f2f07614ad76524cca  shentu-1/genesis.json

Edit config.toml in the config directory to include the seeds.<br />
seeds = "<seed nodes above separated by comma>" (I use vi, but feel free to use other editors)

	vi ~/.certikd/config/config.toml

Add the seeds from : https://github.com/certikfoundation/mainnet/blob/main/shentu-1/seeds.txt <br />
Currently this would result into:

```
seeds = "bfd878cfb358f28204ca9009c7dc63b723dc6b98@52.91.51.227:26656,95c818abe0e7b72e66903835775d5afa884ee1f0@54.224.14.1:26656,0d0b19bca0f30fbdaadd20f1a38b2ea35305169e@100.26.242.20:26656,a48d2e1def5c705b31d77651cd18df0a1aded9b8@3.82.105.31:26656,ff0f27a5db14928ab12059069702689dff1bc6d7@3.238.117.221:26656"
```

Go back to your original directory with the binaries:

	cd ~/Certik

Reset certikd data through the following command:

	./certikd_1.0.0.1023_linux_amd64 unsafe-reset-all

Start certikd daemon.

	./certikd_1.0.0.1023_linux_amd64 start

Let it run for a minute and then kill it.

	use ctrl + c to stop in console
	Or kill the process killall certikd_1.0.0.1023_linux_amd64

Go to the latest version on github and download the certikcli and certikd. (https://github.com/certikfoundation/shentu/releases) <br />
For example:

	wget https://github.com/certikfoundation/shentu/releases/download/v1.3.1/certikcli_1.3.1.0205_linux_amd64
	wget https://github.com/certikfoundation/shentu/releases/download/v1.3.1/certikd_1.3.1.0205_linux_amd64

Update them to correct permissions - change command to correct version. <br />
For example:

	chmod +x certikd_1.3.1.0205_linux_amd64
	chmod +x certikcli_1.3.1.0205_linux_amd64

Implement the certikcli / certikd as binaries so we can just use certikcli and certikd. <br />
For example:

	sudo cp certikd_1.3.1.0205_linux_amd64 /bin/certikd
	sudo cp certikcli_1.3.1.0205_linux_amd64 /bin/certikcli

Perform a quick sync. (https://www.notion.so/Stake-Systems-Fast-Sync-Service-5cb0dffb78174d3494b93f87d242939d) - password on site

	rsync -avhe 'ssh -p23' u250245-sub1@rsync.stakesystems.io:certik/.certikd/data/ ~/.certikd/data/ --delete

Start certikd and continue the sync. It could be that you get a lot of errors in the start but it should start picking up other.

	certikd start.

You can create the wallet through certikcli now:

	certikcli keys add <your-wallet-name>

Once certikd caught up with the height. ( see https://explorer.certik.foundation/?net=shentu-1) <br />
Register your validator - this is using the minimum staked qty of 1 - here it is up to you to configure as wanted, keep in mind there are more options, this is a basic one. <br />
Keep in mind that the minimum staked amount is 1 CTK this is 1000000uctk

	certikcli tx staking create-validator \
	--amount <your-amount-to-stake>uctk \
	--commission-max-change-rate 0.01 \
	--commission-max-rate 0.2 \
	--commission-rate 0.1 \
	--from <your-wallet-name> \
	--min-self-delegation 1 \
	--moniker <your-moniker> \
	--pubkey $(certikd tendermint show-validator) \
	--chain-id shentu-1

### Extra - Starting certikd as a service

As an extra you can run certikd as a service.

	sudo vi /etc/systemd/system/certikd.service

Add following to the file, make sure to change ubuntu to the correct user.

	[Unit]
	Description=CertiK Daemon
	After=network-online.target
	[Service]
	User=ubuntu
	TimeoutStartSec=0
	CPUWeight=90
	IOWeight=90
	ExecStart=/usr/local/bin/certikd start
	Restart=always
	RestartSec=3
	LimitNOFILE=65535
	KillSignal=SIGTERM
	StandardOutput=file:/var/log/certikd.log
	StandardError=file:/var/log/certikd.log
	[Install]
	WantedBy=multi-user.target

Initialize the log file:

	sudo touch /var/log/certikd.log

You can start the service like this:

	sudo systemctl enable certikd
	sudo systemctl start certikd
