# Installing zsh and oh my zsh
sudo apt install zsh -y

# Skip the shell change prompt
ZSH=""
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set zsh as default shell for future users
useradd_path="/etc/default/useradd"
zsh_path=$(which zsh)
sudo sh -c "echo SHELL=$zsh_path >> $useradd_path"

# Set zsh as default shell for current user
chsh -s $zsh_path

# zsh config
config_path="$HOME/.zshrc"
custom_config_path="$HOME/custom_config.zshrc"
wget -O $custom_config_path $custom_config_url
chmod +x $custom_config_path
sudo sh -c "echo source $custom_config_path >> $config_path"

source $config_path
