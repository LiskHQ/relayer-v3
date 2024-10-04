#!/bin/bash
set -eu

echo "Setting environment variables within the current shell on the host"

# Retreive env vars from S3 bucket and source them
source_env_file_name=across-relayer-dev.env
env_file_name=.${source_env_file_name}

aws s3 cp s3://lisk-envs/$source_env_file_name ${env_file_name}
source ${env_file_name}
rm -f ${env_file_name}

echo "Finished setting all the environment variables within the current shell on the host"
