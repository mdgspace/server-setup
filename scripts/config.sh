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
