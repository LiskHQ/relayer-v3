# Install nodejs dependencies
apt update
echo "Current DIR: $PWD"
# Script to install Node.js using NVM on Ubuntu

# Read node version from .nvmrc file
node_version=$(cat .nvmrc | tr -d "\n")

# Function to install NVM
install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

# nvm command is a shell function declared in ~/.nvm/nvm.sh
nvm_path=~/.nvm/nvm.sh

install_node_version() {
    # Check if NVM is installed
    if [ -s "$nvm_path" ];
    then
        echo "NVM is already installed."
        source $nvm_path
    else
        echo "Installing NVM..."
        install_nvm
        source $nvm_path
    fi
    
    echo "Installing Node version $node_version..."
    nvm install $node_version
    nvm use $node_version
}

install_node_version

echo "Node.js version $node_version has been installed."

# Install yarn
npm install --global yarn
echo "***Installed yarn***"
# Install pm2
npm install --global pm2@latest
echo "***Installed pm2***"