#!/bin/bash
app_dir=/home/ubuntu/lisk-across-relayer
cd $app_dir
echo "Current DIR: $PWD"

# Remove previous .env var if any
rm -vf .env

# Setting env var from secrets
secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:mainnet/lisk-across-relayer/aws-CSi7ka
RELAYER_CONFIG=`aws --region eu-west-3 secretsmanager get-secret-value --secret-id ${secret_id} | jq --raw-output .SecretString | jq -r .`

AWSKMS_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWSKMS_CONFIG"`
echo "AWSKMS_CONFIG=$AWSKMS_CONFIG" >> .env

AWS_S3_STORAGE_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWS_S3_STORAGE_CONFIG"`
echo "AWS_S3_STORAGE_CONFIG=$AWS_S3_STORAGE_CONFIG" >> ${app_dir}/.env

RPC_PROVIDER_DRPC_1=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_1"`
echo "RPC_PROVIDER_DRPC_1=$RPC_PROVIDER_DRPC_1" >> ${app_dir}/.env

RPC_PROVIDER_TENDERLY_1=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_TENDERLY_1"`
echo "RPC_PROVIDER_TENDERLY_1=$RPC_PROVIDER_TENDERLY_1" >> ${app_dir}/.env

RPC_PROVIDER_DRPC_1135=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_1135"`
echo "RPC_PROVIDER_DRPC_1135=$RPC_PROVIDER_DRPC_1135" >> ${app_dir}/.env

RPC_PROVIDER_GELATO_1135=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_GELATO_1135"`
echo "RPC_PROVIDER_GELATO_1135=$RPC_PROVIDER_GELATO_1135" >> ${app_dir}/.env

SLACK_CONFIG=`echo $RELAYER_CONFIG | jq -r ."SLACK_CONFIG"`
echo "SLACK_CONFIG=$SLACK_CONFIG" >> ${app_dir}/.env

echo "All env vars from secrets are set."

# Simulation mode OFF
echo "SEND_RELAYS=true" >> ${app_dir}/.env

# RPC provider configuration
echo "RPC_PROVIDERS=DRPC,GELATO,TENDERLY" >> ${app_dir}/.env
echo "RPC_PROVIDERS_1=DRPC,TENDERLY" >> ${app_dir}/.env
echo "RPC_PROVIDERS_1135=GELATO,DRPC" >> ${app_dir}/.env

# Mainnet settings
echo "RELAYER_ORIGIN_CHAINS=[1,1135]" >> ${app_dir}/.env
echo "RELAYER_DESTINATION_CHAINS=[1,1135]" >> ${app_dir}/.env
echo "MIN_RELAYER_FEE_PCT=0.0001" >> ${app_dir}/.env

# Fee settings
echo "PRIORITY_FEE_SCALER_1=0.8"  >> ${app_dir}/.env

# Redis settings
echo "REDIS_URL='redis://127.0.0.1:6379'" >> ${app_dir}/.env

# Supported token settings
echo RELAYER_TOKENS=\'[\"0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2\", \"0x6033F7f88332B8db6ad452B7C6D5bB643990aE3f\", \"0xdAC17F958D2ee523a2206206994597C13D831ec7\"]\'  >> ${app_dir}/.env
echo MIN_DEPOSIT_CONFIRMATIONS=\'{\"5000\": { \"1\": 5, \"1135\": 10 }, \"2000\": { \"1\": 4, \"1135\": 10 }, \"100\": { \"1\": 3, \"1135\": 10 } }\' >> ${app_dir}/.env
echo RELAYER_INVENTORY_CONFIG=\'{ \"wrapEtherTarget\": 0.1, \"wrapEtherThreshold\": 0.125, \"wrapEtherTargetPerChain\": { \"1\": 1 }, \"wrapEtherThresholdPerChain\": { \"1\": 2 }, \"tokenConfig\": { \"WETH\": { \"1\": { \"targetPct\": 100, \"thresholdPct\": 100, \"unwrapWethThreshold\": 0.5, \"unwrapWethTarget\": 1 }, \"1135\": { \"targetPct\": 30, \"thresholdPct\": 10, \"unwrapWethThreshold\": 0.025, \"unwrapWethTarget\": 0.1, \"targetOverageBuffer\": 1.5 }}, \"LSK\": { \"1135\": { \"targetPct\": 30, \"thresholdPct\": 10, \"targetOverageBuffer\": 1.75 }}, \"USDT\": { \"1135\": { \"targetPct\": 30, \"thresholdPct\": 10, \"targetOverageBuffer\": 1.5 }}}}\' >> ${app_dir}/.env

echo "All env vars are set."

# PM2 runs on the fall back path when using CodeDeploy agent and we can run with the given fall back path
export PM2_HOME=/etc/.pm2
sudo -E pm2 delete all # Delete any running app
sudo -E pm2 start --name "lisk-across-relayer" "node ${app_dir}/dist/index.js --relayer --wallet awskms --keys "relayerKey""