#!/bin/bash

echo "Execution started (main.sh)"

# region scripts/config.sh
echo "Execution started (config.sh)"

# Constants
webpage_path="/var/www/html/mdgspace.html"

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

# Snapd
sudo apt install snapd -y

# Git

# Docker

# Nginx

# Certbot

echo "Execution completed (install.sh)"
# endregion scripts/install.sh

# region scripts/zsh.sh
# endregion scripts/zsh.sh

# region scripts/webpage.sh
html_page_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/index.html"

html_content=$(curl -s $html_page_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

echo "$modified_html_content" | sudo tee "$webpage_path" > /dev/null

echo "Webpage created at $webpage_path"
# endregion scripts/webpage.sh


echo "Execution completed (main.sh)"
