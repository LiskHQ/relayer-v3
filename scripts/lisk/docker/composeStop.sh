#!/bin/bash
set -eu

. $(dirname "$0")/changeToAppInstallDir.sh

. $(dirname "$0")/setEnvVariables.sh

# Wait for the CI to build and push the Docker image to ECR
sleep 300
docker compose down --rmi all
