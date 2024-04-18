#!/bin/bash

# Redirect stdout and stderr to both console and log file
exec > >(tee -i "setup.log") 2>&1

# region scripts/config.sh
# Constants
webpage_path="/var/www/html/index.html"
webpage_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/downloads/index.html"
banner_url="https://raw.githubusercontent.com/mdgspace/server-map/main/banner.sh"
system_wide_bashrc="/etc/bash.bashrc"
system_skel_bashrc="/etc/skel/.bashrc"
aliases_path="/etc/.bash_aliases"
aliases_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/downloads/aliases.sh"

# Prompt for confirmation to run the script
read -p "Do you want to run the script? (yes/no) " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Script execution cancelled"
    exit 1
fi

# Prompt user for server name
read -p "Enter server name: " server_name

if [ -z "$server_name" ]; then
    echo "Server name cannot be empty"
    exit 1
fi

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
# endregion scripts/install.sh

# region scripts/shell.sh
sudo chmod a+r "$system_wide_bashrc"

sudo sh -c "echo '' >> '$system_wide_bashrc'"
sudo sh -c "echo '# Custom configuration' >> '$system_wide_bashrc'"

sudo sh -c "echo 'export server_name=$server_name' >> '$system_wide_bashrc'"

# Beautify the bash prompt
ps1_var="PS1='\[\e[92m\]\u@${server_name}\[\e[0m\]:\[\e[91m\]\w\\$\[\e[0m\] '"
sudo sh -c "echo '' >> '$system_skel_bashrc'"
sudo sh -c "echo '# Custom configuration' >> '$system_skel_bashrc'"
sudo sh -c "echo \"$ps1_var\" >> '$system_skel_bashrc'"

echo "" >> "$HOME/.bashrc"
echo "# Custom configuration" >> "$HOME/.bashrc"
echo "$ps1_var" >> "$HOME/.bashrc"

# Banner (server-map)
response=$(curl -s $banner_url)

# Delete first line ("$server_name" variable)
modified_response=$(echo "$response" | sed "1d")

sudo sh -c "echo '# Banner' >> '$system_wide_bashrc'"
sudo sh -c "echo '$modified_response' >> '$system_wide_bashrc'"

# Aliases
sudo curl -o "$aliases_path" "$aliases_url"
sudo chmod a+r "$aliases_path"
sudo sh -c "echo '. \"$aliases_path\"' >> '$system_wide_bashrc'"
# endregion scripts/shell.sh

# region scripts/iam.sh
sudo usermod -aG docker $USER

password=$(< /dev/urandom tr -dc '[:alnum:]' | head -c12)
sudo adduser --disabled-password --gecos "" developers
echo "developers:$password" | sudo chpasswd
sudo usermod -aG docker developers

# Generate a new key pair
ssh-keygen -t rsa -b 2048 -f temp_rsa_key -N ""

echo "ssh info for developers (non root users):"
echo "------Copy the following private key and save it in a secure place------"
cat temp_rsa_key
echo "----------------------------------------------------------------------"

PUBLIC_KEY=$(cat temp_rsa_key.pub)

sudo mkdir /home/developers/.ssh
sudo chown developers:developers /home/developers/.ssh
sudo chmod 700 /home/developers/.ssh

sudo sh -c "echo $PUBLIC_KEY >> /home/developers/.ssh/authorized_keys"
sudo chown developers:developers /home/developers/.ssh/authorized_keys
sudo chmod 600 /home/developers/.ssh/authorized_keys

rm temp_rsa_key temp_rsa_key.pub
# endregion scripts/iam.sh

# region scripts/webpage.sh
html_content=$(curl -s $webpage_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

# Create the new webpage
sudo sh -c "echo '$modified_html_content' > $webpage_path"

echo "Webpage created at $webpage_path"
# endregion scripts/webpage.sh

# region scripts/verify.sh
# Verify Installation

# snapd
if ! command -v snap &> /dev/null; then
  echo "snapd is not installed"
fi

# git
if ! command -v git &> /dev/null; then
  echo "git is not installed"
fi

# docker
if ! command -v docker &> /dev/null; then
  echo "docker is not installed"
fi

# nginx
if ! command -v nginx &> /dev/null; then
  echo "nginx is not installed"
fi

# certbot
if ! command -v certbot &> /dev/null; then
  echo "certbot is not installed"
fi

# Verify User
if ! id -u developers &>/dev/null; then
  echo "non root user 'developers' is not created"
fi
# endregion scripts/verify.sh


echo "Setup script executed successfully"
