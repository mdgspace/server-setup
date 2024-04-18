sudo chmod a+r "$system_wide_bashrc"

sudo sh -c "echo '' >> '$system_wide_bashrc'"
sudo sh -c "echo '# Custom configuration' >> '$system_wide_bashrc'"

sudo sh -c "echo 'export server_name=$server_name' >> '$system_wide_bashrc'"

# Beautify the bash prompt
ps1_var="PS1='\[\e[92m\]\u@${server_name}\[\e[0m\]:\[\e[91m\]\w\\$\[\e[0m\] '"
sudo sh -c "echo '$ps1_var' >> '$system_wide_bashrc'"

# Banner (server-map)
response=$(curl -s $banner_url)

# Delete first line ("$server_name" variable)
modified_response=$(echo "$response" | sed "1d")

sudo sh -c "echo '# Banner' >> '$system_wide_bashrc'"
sudo sh -c "echo '$modified_response' >> '$system_wide_bashrc'"

# Aliases
sudo curl -o "$aliases_path" "$aliases_url"
sudo sh -c "echo '. $aliases_path' >> '$system_wide_bashrc'"
