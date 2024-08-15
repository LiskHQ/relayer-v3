#!/bin/bash

# Load NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Change to application directory
app_dir_name=/home/ubuntu/lisk-across-relayer
cd $app_dir_name
echo "Current DIR: $PWD"

# Install application
nvm use
yarn install --frozen-lockfile
yarn build