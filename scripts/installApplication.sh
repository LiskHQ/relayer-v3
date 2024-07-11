#!/bin/bash

# Install application
app_dir_name="/home/ubuntu/lisk-across-relayer"
mkdir app_dir_name
cd app_dir_name
echo "Current DIR: $PWD"
sudo yarn install
sudo yarn build