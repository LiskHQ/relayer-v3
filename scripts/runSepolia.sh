#!/bin/bash
cd /home/ubuntu/lisk-across-relayer
app_name="testnet-across-relayer-simulated"
pm2 stop $app_name
pm2 start pm2.config.js --only $app_name