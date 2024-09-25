#!/bin/bash
set -eu

# Set env var from secrets
secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:mainnet/lisk-across-relayer/aws-CSi7ka
# secret_id=arn:aws:secretsmanager:eu-west-3:132202091885:secret:sepolia/across-relayer-dev/aws-7CIqpl
RELAYER_CONFIG=`aws --region eu-west-3 secretsmanager get-secret-value --secret-id ${secret_id} | jq --raw-output .SecretString | jq -r .`

echo "Setting environment variables within the current shell on the host"

export AWS_REGION=`echo $RELAYER_CONFIG | jq -r ."AWS_REGION"`

export AWS_ECR_REGISTRY=`echo $RELAYER_CONFIG | jq -r ."AWS_ECR_REGISTRY"`

export AWS_ECR_REPOSITORY=`echo $RELAYER_CONFIG | jq -r ."AWS_ECR_REPOSITORY"`

export ACROSS_RELAYER_IMAGE_TAG=`echo $RELAYER_CONFIG | jq -r ."ACROSS_RELAYER_IMAGE_TAG"`

export NETWORK=`echo $RELAYER_CONFIG | jq -r ."NETWORK"`

export RELAYER_1_API_SERVER_HOST=`echo $RELAYER_CONFIG | jq -r ."RELAYER_1_API_SERVER_HOST"`

export REBALANCER_API_SERVER_HOST=`echo $RELAYER_CONFIG | jq -r ."REBALANCER_API_SERVER_HOST"`

export RELAYER_1_API_SERVER_PORT=`echo $RELAYER_CONFIG | jq -r ."RELAYER_1_API_SERVER_PORT"`

export REBALANCER_API_SERVER_PORT=`echo $RELAYER_CONFIG | jq -r ."REBALANCER_API_SERVER_PORT"`

echo "Finished setting all the environment variables within the current shell on the host"
