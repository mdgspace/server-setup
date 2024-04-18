# Constants
webpage_path="/var/www/html/index.html"
webpage_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/downloads/index.html"
banner_url="https://raw.githubusercontent.com/mdgspace/server-map/main/banner.sh"
system_wide_bashrc="/etc/bash.bashrc"
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
