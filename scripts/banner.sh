url="https://raw.githubusercontent.com/mdgspace/server-map/main/banner.sh"
response=$(curl -s $url)

# Delete first line "$server_name" variable
modified_response=$(echo "$response" | sed '1d')

output=$(eval "$modified_response")

echo "$output" | sudo tee "/etc/ssh/banner.txt" >> /dev/null

echo "Banner /etc/ssh/banner.txt" | sudo tee -a "/etc/ssh/sshd_config" >> /dev/null
