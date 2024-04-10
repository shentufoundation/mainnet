#!/bin/bash

set -ux
set -e
set -v

RPC_ADDR="https://shenturpc.noopsbycertik.com"
INTERVAL=1500

LATEST_HEIGHT=$(curl -s $RPC_ADDR/block | jq -r .result.block.header.height);
BLOCK_HEIGHT=$(($LATEST_HEIGHT-$INTERVAL))
TRUST_HASH=$(curl -s "$RPC_ADDR/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

# TELL USER WHAT WE ARE DOING
echo "TRUST HEIGHT: $BLOCK_HEIGHT"
echo "TRUST HASH: $TRUST_HASH"

export SHENTUD_STATESYNC_ENABLE=true
export SHENTUD_STATESYNC_RPC_SERVERS="$RPC_ADDR,$RPC_ADDR"
export SHENTUD_STATESYNC_TRUST_HEIGHT=$BLOCK_HEIGHT
export SHENTUD_STATESYNC_TRUST_HASH=$TRUST_HASH

shentud start
