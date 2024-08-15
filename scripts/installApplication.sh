#!/bin/bash

# Install application
app_dir_name=/home/ubuntu/lisk-across-relayer
cd $app_dir_name
echo "Current DIR: $PWD"

nvm use
yarn install --frozen-lockfile
yarn build