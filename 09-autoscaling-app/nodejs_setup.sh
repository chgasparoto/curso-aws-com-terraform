#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Install NodeJS
echo "Installing NodeJS"
touch .bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. /.nvm/nvm.sh
nvm install --lts

# Clone website code
echo "Cloning website"
mkdir -p /demo-website
cd /demo-website
git clone https://github.com/academind/aws-demos.git .
cd dynamic-website-scaling

# Install dependencies
echo "Installing dependencies"
npm install

# Forward port 80 traffic to port 3000
echo "Forwarding 80 -> 3000"
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000

# Install & use pm2 to run Node app in background
echo "Installing & starting pm2"
npm install pm2@latest -g
pm2 start app.js
