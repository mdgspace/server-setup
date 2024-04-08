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
