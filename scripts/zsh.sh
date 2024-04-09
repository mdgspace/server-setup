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
