# Install nodejs dependencies
sudo apt update
sudo apt install nodejs
sudo apt install npm
# Install pm2
sudo npm install pm2@latest -g
# Install application
yarn install
yarn build