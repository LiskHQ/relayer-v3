#!/bin/bash
app_dir=/home/ubuntu/lisk-across-relayer
cd $app_dir
echo "Current DIR: $PWD"
export RELAYER_TOKENS='["0x16B840bA01e2b05fc2268eAf6d18892a11EC29D6", "0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0", "0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14"]'
export MIN_DEPOSIT_CONFIRMATIONS='{ "1000000": { "919": 1, "4202": 1, "80002": 1, "84532": 1, "421614": 1, "11155111": 1, "11155420": 1 } }'
export RELAYER_IGNORE_LIMITS=true
export REDIS_URL="redis://127.0.0.1:6379"
export RELAYER_ORIGIN_CHAINS=[11155111,4202]
export RELAYER_DESTINATION_CHAINS=[11155111,4202]
export HUB_CHAIN_ID=11155111
pm2 stop all # Stop any running app
pm2 start "MNEMONIC='job hedgehog wing decorate cup club hunt horn rude cancel bridge carry frog toss ugly' SEND_RELAYS=false yarn relay --wallet mnemonic"