echo "" >> "$HOME/.bashrc"
echo "# Custom configuration" >> "$HOME/.bashrc"

echo "export server_name=$server_name" >> "$HOME/.bashrc"

# Beautify the bash prompt
ps1_var="PS1='\[\e[92m\]\u@${server_name}\[\e[0m\]:\[\e[91m\]\w\\$\[\e[0m\] '"
echo $ps1_var >> "$HOME/.bashrc"

# Banner (server-map)
response=$(curl -s $banner_url)

# Delete first line ("$server_name" variable)
modified_response=$(echo "$response" | sed "1d")

echo "$modified_response" >> "$HOME/.bashrc"
