#!/bin/bash
set -eu

. $(dirname "$0")/changeToAppInstallDir.sh

. $(dirname "$0")/setEnvVariables.sh

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ECR_REGISTRY}
docker compose up --pull always --detach
