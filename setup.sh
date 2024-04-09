#!/bin/bash

echo "Execution started (main.sh)"

# region scripts/config.sh
echo "Execution started (config.sh)"

# Constants
webpage_path="/var/www/html/index.html"

# Prompt for confirmation to run the script
echo "Do you want to run the script? (yes/no)"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Script execution cancelled"
    exit 1
fi

# Prompt user for server name
echo "server name:"
read server_name

# Enable sudo
sudo echo "sudo enabled"

echo "Execution completed (config.sh)"
# endregion scripts/config.sh

# region scripts/install.sh
echo "Execution started (install.sh)"

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Utilities
sudo apt install coreutils -y
sudo apt install build-essential -y
sudo apt install wget
sudo apt install curl

# Snapd
sudo apt install snapd -y

# Git
sudo apt install git -y
git config --global user.name "$server_name"

# Docker
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Nginx
sudo apt install nginx -y

# Certbot
sudo snap install --classic certbot -y
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo "Execution completed (install.sh)"
# endregion scripts/install.sh

# region scripts/zsh.sh
echo "Execution started (zsh.sh)"

# Installing zsh and oh my zsh
sudo apt install zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chsh -s $(which zsh)

# zsh config
custom_config_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/custom_config.zshrc"
config_path="$HOME/.zshrc"
custom_config="$HOME/custom_config.zshrc"
wget -O $custom_config $custom_config_url
chmod +x $custom_config
echo "source $custom_config" | sudo tee -a "$config_path" > /dev/null

echo "Execution completed (zsh.sh)"
# endregion scripts/zsh.sh

# region scripts/webpage.sh
html_page_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/index.html"

html_content=$(curl -s $html_page_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

echo "$modified_html_content" | sudo tee "$webpage_path" > /dev/null

echo "Webpage created at $webpage_path"
# endregion scripts/webpage.sh


echo "Execution completed (main.sh)"
