# Install nodejs dependencies
sudo apt update
echo "$PWD"
sudo apt install nodejs
echo "***Installed nodejs***"
sudo apt install npm
echo "***Installed npm***"
# Install yarn
sudo npm install --global yarn
echo "***Installed yarn***"
# Install pm2
sudo npm install pm2@latest -g
echo "***Installed pm2***"
# Install application
echo "$PWD"
sudo yarn install
sudo yarn build