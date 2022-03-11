#!/bin/bash

set -ux
set -e
set -v

# Please, update to RPC_ADDR to 3.236.161.42:26657 if you like to use Certik official RPC Node
# Given address is DSRV RPC Node Address.
RPC_ADDR="165.232.72.33:26657"
INTERVAL=1500

LATEST_HEIGHT=$(curl -s $RPC_ADDR/block | jq -r .result.block.header.height);
BLOCK_HEIGHT=$(($LATEST_HEIGHT-$INTERVAL))
TRUST_HASH=$(curl -s "$RPC_ADDR/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

# TELL USER WHAT WE ARE DOING
echo "TRUST HEIGHT: $BLOCK_HEIGHT"
echo "TRUST HASH: $TRUST_HASH"

export CERTIK_STATESYNC_ENABLE=true
export CERTIK_STATESYNC_RPC_SERVERS="$RPC_ADDR,$RPC_ADDR"
export CERTIK_STATESYNC_TRUST_HEIGHT=$BLOCK_HEIGHT
export CERTIK_STATESYNC_TRUST_HASH=$TRUST_HASH

certik start &