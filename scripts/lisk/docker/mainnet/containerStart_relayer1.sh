#!/bin/bash

. $(dirname $(realpath "$0"))/setCommonEnv.sh

# Relaying ON rebalancing OFF
echo "SEND_RELAYS=true" >> ${env_file}
echo "SEND_REBALANCES=false"  >> ${env_file}
echo "All env vars are set."

node ${app_dir}/dist/index.js --relayer --wallet awskms --keys relayerKey
