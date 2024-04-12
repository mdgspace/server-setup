#!/bin/bash

# region scripts/config.sh
# Constants
webpage_path="/var/www/html/index.html"
webpage_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/downloads/index.html"
custom_config_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/downloads/custom_config.zshrc"
banner_url="https://raw.githubusercontent.com/mdgspace/server-map/main/banner.sh"

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
# endregion scripts/config.sh

# region scripts/install.sh
# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Utilities
sudo apt install coreutils -y
sudo apt install build-essential -y
sudo apt install wget -y
sudo apt install curl -y
sudo apt install figlet -y

# Snapd
sudo apt install snapd -y

# Git
sudo apt install git -y
git config --global user.name "$server_name"

# Docker
sudo apt-get update -y
sudo apt-get install ca-certificates -y
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
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot
# endregion scripts/install.sh

# region scripts/iam.sh
sudo usermod -aG docker $USER
sudo adduser stargazers
sudo usermod -aG docker stargazers

# Copy the public key to the new user
sudo mkdir /home/stargazers/.ssh
sudo chown stargazers:stargazers /home/stargazers/.ssh
sudo chmod 700 /home/stargazers/.ssh

echo "Provide the public key for non sudo user (stargazers)"
read PUBLIC_KEY

sudo sh -c "echo $PUBLIC_KEY >> /home/stargazers/.ssh/authorized_keys"
sudo chown stargazers:stargazers /home/stargazers/.ssh/authorized_keys
sudo chmod 600 /home/stargazers/.ssh/authorized_keys
# endregion scripts/iam.sh

# region scripts/webpage.sh
html_content=$(curl -s $webpage_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

# Create the new webpage
sudo sh -c "echo '$modified_html_content' > $webpage_path"

echo "Webpage created at $webpage_path"
# endregion scripts/webpage.sh

# region scripts/banner.sh
response=$(curl -s $banner_url)

# Delete first line "$server_name" variable
modified_response=$(echo "$response" | sed "1s/.*/server_name=$server_name/")

echo "$modified_response" >> "$HOME/.bashrc"
# endregion scripts/banner.sh

