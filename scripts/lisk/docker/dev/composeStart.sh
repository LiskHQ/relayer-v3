#!/bin/bash
set -eu

. $(dirname $(realpath "$0"))/changeToAppInstallDir.sh

. scripts/lisk/docker/dev/setEnvVariables.sh

mkdir -p $PWD/.aws
cp $HOME/.aws/credentials $PWD/.aws/
git apply scripts/lisk/docker/dev/docker-compose-dev.patch

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ECR_REGISTRY}
docker compose up --pull always --detach
