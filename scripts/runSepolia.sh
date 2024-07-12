#!/bin/bash
app_dir=/home/ubuntu/lisk-across-relayer
cd $app_dir
echo "Current DIR: $PWD"

# Remove previous .env var if any
rm -vf .env

# Setting env var from secrets
secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:testnet/lisk-across-relayer/aws-WBAwo1
RELAYER_CONFIG=`aws --region eu-west-3 secretsmanager get-secret-value --secret-id ${secret_id} | jq --raw-output .SecretString | jq -r .`

AWSKMS_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWSKMS_CONFIG"`
echo "AWSKMS_CONFIG=$AWSKMS_CONFIG" >> .env

AWS_S3_STORAGE_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWS_S3_STORAGE_CONFIG"`
echo "AWS_S3_STORAGE_CONFIG=$AWS_S3_STORAGE_CONFIG" >> ${app_dir}/.env

RPC_PROVIDER_DRPC_11155111=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_11155111"`
echo "RPC_PROVIDER_DRPC_11155111=$RPC_PROVIDER_DRPC_11155111" >> ${app_dir}/.env

RPC_PROVIDER_TENDERLY_11155111=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_TENDERLY_11155111"`
echo "RPC_PROVIDER_TENDERLY_11155111=$RPC_PROVIDER_TENDERLY_11155111" >> ${app_dir}/.env

RPC_PROVIDER_DRPC_4202=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_4202"`
echo "RPC_PROVIDER_DRPC_4202=$RPC_PROVIDER_DRPC_4202" >> ${app_dir}/.env

RPC_PROVIDER_GELATO_4202=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_GELATO_4202"`
echo "RPC_PROVIDER_GELATO_4202=$RPC_PROVIDER_GELATO_4202" >> ${app_dir}/.env

echo "All env vars from secrets are set."

# Simulation mode ON
echo "SEND_RELAYS=true" >> ${app_dir}/.env
# RPC provider configuration
echo "RPC_PROVIDERS=TENDERLY,GELATO,DRPC" >> ${app_dir}/.env
echo "RPC_PROVIDERS_11155111=TENDERLY,DRPC" >> ${app_dir}/.env
echo "RPC_PROVIDERS_4202=GELATO,DRPC" >> ${app_dir}/.env

# Sepolia testnet settings
echo "RELAYER_IGNORE_LIMITS=true" >> ${app_dir}/.env
echo "HUB_CHAIN_ID=11155111" >> ${app_dir}/.env
echo "RELAYER_ORIGIN_CHAINS=[11155111,4202]" >> ${app_dir}/.env
echo "RELAYER_DESTINATION_CHAINS=[11155111,4202]" >> ${app_dir}/.env
# Redis settings
echo "REDIS_URL='redis://127.0.0.1:6379'" >> ${app_dir}/.env
# Supported token settings
echo RELAYER_TOKENS=\'[\"0x16B840bA01e2b05fc2268eAf6d18892a11EC29D6\", \"0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0\", \"0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14\"]\'  >> ${app_dir}/.env
echo MIN_DEPOSIT_CONFIRMATIONS=\'{ \"1000000\": { \"919\": 1, \"4202\": 1, \"80002\": 1, \"84532\": 1, \"421614\": 1, \"11155111\": 1, \"11155420\": 1 } }\' >> ${app_dir}/.env

echo "All env vars are set."

# PM2 runs on the fall back path when using CodeDeploy agent and we can run with the given fall back path
export PM2_HOME=/etc/.pm2
sudo -E pm2 delete all # Delete any running app
sudo -E pm2 start "node ${app_dir}/dist/index.js --relayer --wallet awskms --keys "relayerKey""