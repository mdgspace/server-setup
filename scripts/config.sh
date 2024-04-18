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

if [ -z "$server_name" ]; then
    echo "Server name cannot be empty"
    exit 1
fi

# Enable sudo
sudo echo "sudo enabled"
