# Install nodejs dependencies
sudo apt update
echo "Current DIR: $PWD"
sudo apt install nodejs
echo "***Installed nodejs***"
sudo apt install npm
echo "***Installed npm***"
# Install yarn
sudo npm install --global yarn
echo "***Installed yarn***"
# Install pm2
sudo npm install --global pm2@latest
echo "***Installed pm2***"