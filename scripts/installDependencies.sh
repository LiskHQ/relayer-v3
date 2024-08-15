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

    # Add NVM load commands to .bashrc
    if [ ! -f "$HOME/.bashrc" ];
    then
        touch $HOME/.bashrc
    fi
    if [ $(grep NVM_DIR "$HOME/.bashrc" | wc -l) -ge 2 ];
    then
        echo "NVM commands are already added to .bashrc"
    else
        echo "export NVM_DIR=\"\$HOME/.nvm\"" >> "$HOME/.bashrc"
        echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm" >> "$HOME/.bashrc"
    fi

    # Ensure NVM is now available in PATH
    source "$HOME/.bashrc"
}

install_node_version() {
    # Check if NVM is installed
    if [ -s "$NVM_DIR/nvm.sh" ];
    then
        echo "NVM is already installed."
    else
        echo "Installing NVM..."
        install_nvm
    fi

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