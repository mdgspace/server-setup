response=$(curl -s $banner_url)

# Delete first line "$server_name" variable
modified_response=$(echo "$response" | sed "1s/.*/server_name=$server_name/")

echo "$modified_response" >> "$HOME/.bashrc"
