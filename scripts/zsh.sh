# Installing zsh and oh my zsh
sudo apt install zsh
sudo chsh -s $(which zsh) ubuntu
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh config
config_path="$HOME/.zshrc"
custom_config="$HOME/custom_config.zshrc"
wget -O $custom_config $custom_config_url
chmod +x $custom_config
echo "source $custom_config" | sudo tee -a "$config_path" >> /dev/null
