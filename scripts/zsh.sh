custom_config_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/scripts/custom_config.zshrc"
custom_config_path="$HOME/.zshrc"
custom_config="$HOME/custom_config.zshrc"

wget -O $custom_config $custom_config_url
chmod +x custom_config

echo "source custom_config" | sudo tee -a "$custom_config_path" > /dev/null
