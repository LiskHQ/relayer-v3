#!/bin/bash
app_dir=$PWD
echo "Current DIR: $PWD"

# Remove previous .env var if any
readonly env_file="${app_dir}/.env"
rm -f ${env_file}

# Setting env var from secrets
secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:mainnet/lisk-across-relayer/aws-CSi7ka
RELAYER_CONFIG=`aws --region eu-west-3 secretsmanager get-secret-value --secret-id ${secret_id} | jq --raw-output .SecretString | jq -r .`

AWSKMS_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWSKMS_CONFIG"`
echo "AWSKMS_CONFIG=$AWSKMS_CONFIG" >> ${env_file}

AWS_S3_STORAGE_CONFIG=`echo $RELAYER_CONFIG | jq -r ."AWS_S3_STORAGE_CONFIG"`
echo "AWS_S3_STORAGE_CONFIG=$AWS_S3_STORAGE_CONFIG" >> ${env_file}

RPC_PROVIDER_DRPC_1=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_1"`
echo "RPC_PROVIDER_DRPC_1=$RPC_PROVIDER_DRPC_1" >> ${env_file}

RPC_PROVIDER_TENDERLY_1=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_TENDERLY_1"`
echo "RPC_PROVIDER_TENDERLY_1=$RPC_PROVIDER_TENDERLY_1" >> ${env_file}

RPC_PROVIDER_DRPC_1135=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_DRPC_1135"`
echo "RPC_PROVIDER_DRPC_1135=$RPC_PROVIDER_DRPC_1135" >> ${env_file}

RPC_PROVIDER_GELATO_1135=`echo $RELAYER_CONFIG | jq -r ."RPC_PROVIDER_GELATO_1135"`
echo "RPC_PROVIDER_GELATO_1135=$RPC_PROVIDER_GELATO_1135" >> ${env_file}

SLACK_CONFIG=`echo $RELAYER_CONFIG | jq -r ."SLACK_CONFIG"`
echo "SLACK_CONFIG=$SLACK_CONFIG" >> ${env_file}

echo "All env vars from secrets are set."

# Set the bot identifier
echo "BOT_IDENTIFIER=LISK_ACROSS_REBALANCER"  >> ${env_file}

# Relaying OFF rebalancing ON
echo "SEND_RELAYS=false" >> ${env_file}
echo "SEND_REBALANCES=true"  >> ${env_file}

# Looping mode OFF
POLLING_DELAY=0

# RPC provider configuration
echo "RPC_PROVIDERS=DRPC,GELATO,TENDERLY" >> ${env_file}
echo "RPC_PROVIDERS_1=DRPC,TENDERLY" >> ${env_file}
echo "RPC_PROVIDERS_1135=GELATO,DRPC" >> ${env_file}

# Mainnet settings
echo "RELAYER_ORIGIN_CHAINS=[1,1135]" >> ${env_file}
echo "RELAYER_DESTINATION_CHAINS=[1,1135]" >> ${env_file}
echo "MIN_RELAYER_FEE_PCT=0.00005" >> ${env_file}

# Fee settings
echo "PRIORITY_FEE_SCALER_1=0.8"  >> ${env_file}
echo "RELAYER_GAS_PADDING=0"  >> ${env_file}

# Supported token settings
echo RELAYER_TOKENS=\'[\"0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2\", \"0x6033F7f88332B8db6ad452B7C6D5bB643990aE3f\", \"0xdAC17F958D2ee523a2206206994597C13D831ec7\"]\'  >> ${env_file}
echo MIN_DEPOSIT_CONFIRMATIONS=\'{\"5000\": { \"1\": 5, \"1135\": 10 }, \"2000\": { \"1\": 4, \"1135\": 10 }, \"100\": { \"1\": 3, \"1135\": 10 } }\' >> ${env_file}
echo RELAYER_EXTERNAL_INVENTORY_CONFIG=\'config/mainnet/relayerExternalInventory.json\' >> ${env_file}

echo "All env vars are set."

node ${app_dir}/dist/index.js --relayer --wallet awskms --keys relayerKey