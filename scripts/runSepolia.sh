#!/bin/bash
app_dir=/home/ubuntu/lisk-across-relayer
cd $app_dir
echo "Current DIR: $PWD"

# Remove previous .env var if any
rm -vf .env

# Setting env var from secrets
secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:testnet/lisk-across-relayer/aws-WBAwo1
RELAYER_CONFIG=`aws --region eu-west-3 secretsmanager get-secret-value --secret-id ${secret_id} | jq --raw-output .SecretString | jq -r .`

# AWS config
AWSKMS_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWSKMS_CONFIG"`
echo "AWSKMS_CONFIG=$AWSKMS_CONFIG" >> .env

AWS_S3_STORAGE_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWS_S3_STORAGE_CONFIG"`
echo "AWS_S3_STORAGE_CONFIG=$AWS_S3_STORAGE_CONFIG" >> ${app_dir}/.env

# RPC poviders url
RPC_PROVIDER_DRPC_11155111=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_11155111"`
echo "RPC_PROVIDER_DRPC_11155111=$RPC_PROVIDER_DRPC_11155111" >> ${app_dir}/.env

RPC_PROVIDER_TENDERLY_11155111=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_TENDERLY_11155111"`
echo "RPC_PROVIDER_TENDERLY_11155111=$RPC_PROVIDER_TENDERLY_11155111" >> ${app_dir}/.env

RPC_PROVIDER_DRPC_4202=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_4202"`
echo "RPC_PROVIDER_DRPC_4202=$RPC_PROVIDER_DRPC_4202" >> ${app_dir}/.env

RPC_PROVIDER_GELATO_4202=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_GELATO_4202"`
echo "RPC_PROVIDER_GELATO_4202=$RPC_PROVIDER_GELATO_4202" >> ${app_dir}/.env

# Simulation mode ON
SEND_RELAYS=`echo $RELAYER_CONFIG | jq -r ."SEND_RELAYS"`
echo "SEND_RELAYS=$SEND_RELAYS" >> ${app_dir}/.env

# RPC provider configuration
RPC_PROVIDERS=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDERS"`
echo "RPC_PROVIDERS=$RPC_PROVIDERS" >> ${app_dir}/.env

RPC_PROVIDERS_11155111=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDERS_11155111"`
echo "RPC_PROVIDERS_11155111=$RPC_PROVIDERS_11155111" >> ${app_dir}/.env

RPC_PROVIDERS_4202=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDERS_4202"`
echo "RPC_PROVIDERS_4202=$RPC_PROVIDERS_4202" >> ${app_dir}/.env

# Mainnet settings
RELAYER_ORIGIN_CHAINS=`echo $RELAYER_CONFIG | jq -r ."RELAYER_ORIGIN_CHAINS"`
echo "RELAYER_ORIGIN_CHAINS=$RELAYER_ORIGIN_CHAINS" >> ${app_dir}/.env

RELAYER_DESTINATION_CHAINS=`echo $RELAYER_CONFIG | jq -r ."RELAYER_DESTINATION_CHAINS"`
echo "RELAYER_DESTINATION_CHAINS=$RELAYER_DESTINATION_CHAINS" >> ${app_dir}/.env

MIN_RELAYER_FEE_PCT=`echo $RELAYER_CONFIG | jq -r ."MIN_RELAYER_FEE_PCT"`
echo "MIN_RELAYER_FEE_PCT=$MIN_RELAYER_FEE_PCT" >> ${app_dir}/.env

# Redis settings
REDIS_URL=`echo $RELAYER_CONFIG | jq -r ."REDIS_URL"`
echo "REDIS_URL=$REDIS_URL" >> ${app_dir}/.env
# Supported token settings
RELAYER_TOKENS=`echo $RELAYER_CONFIG | jq -r ."RELAYER_TOKENS"`
echo "RELAYER_TOKENS=$RELAYER_TOKENS" >> ${app_dir}/.env

MIN_DEPOSIT_CONFIRMATIONS=`echo $RELAYER_CONFIG | jq -r ."MIN_DEPOSIT_CONFIRMATIONS"`
echo "MIN_DEPOSIT_CONFIRMATIONS=$MIN_DEPOSIT_CONFIRMATIONS" >> ${app_dir}/.env

echo "All env vars from secrets are set."

# PM2 runs on the fall back path when using CodeDeploy agent and we can run with the given fall back path
export PM2_HOME=/etc/.pm2
sudo -E pm2 delete all # Delete any running app
sudo -E pm2 start --name "lisk-across-relayer" "node ${app_dir}/dist/index.js --relayer --wallet awskms --keys "relayerKey""