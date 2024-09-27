#!/bin/bash
set -eu

. $(dirname "$0")/changeToAppInstallDir.sh

. $(dirname "$0")/setEnvVariables.sh

docker compose down --rmi all
