#!/bin/bash
# Script to install Node.js using NVM on Ubuntu

app_dir_name=/home/ubuntu/lisk-across-relayer
cd $app_dir_name
echo "Current DIR: $PWD"

# Read node version from .nvmrc file
node_version=$(cat .nvmrc | tr -d "\n")
if [[ -z "${node_version-}" ]];
then
    echo ".nvmrc not found; exiting..."
    exit 1
fi

# Function to install NVM
install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
}

install_node_version() {
    # Setting up environment for NVM    
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

    # Check if NVM is installed
    if [ -s "$NVM_DIR/nvm.sh" ];
    then
        echo "NVM is already installed."
    else
        echo "Installing NVM..."
        install_nvm
    fi

    # Load NVM
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo "Installing Node version $node_version..."
    nvm install $node_version
    nvm alias default $node_version
}

install_node_version
echo "Node.js version $node_version has been installed."

# Install yarn
npm install --global yarn

# Install pm2
npm install --global pm2@latest