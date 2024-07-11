#!/bin/bash
cd /home/ubuntu/lisk-across-relayer
echo "Current DIR: $PWD"
app_name="testnet-across-relayer-simulated"
echo "PM2 app name: $app_name"
pm2 stop $app_name
echo "Stopped previous app: $app_name"
pm2 start pm2.config.js --only $app_name
echo "Started app: $app_name"