#!/bin/bash
set -eu

echo "Setting environment variables within the current shell on the host"

# Retreive env vars from S3 bucket and source them
file_name=across-relayer-mainnet.env
aws s3 cp s3://lisk-envs/$file_name .${file_name}
source .${file_name}
rm -f .${file_name}

echo "Finished setting all the environment variables within the current shell on the host"
