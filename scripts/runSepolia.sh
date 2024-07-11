#!/bin/bash
app_dir=/home/ubuntu/lisk-across-relayer
echo "Current DIR: $PWD"
pm2 stop all
pm2 start $app_dir/pm2.config.js --only "testnet-across-relayer-simulated"