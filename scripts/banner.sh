#!/bin/bash

url="https://raw.githubusercontent.com/mdgspace/server-map/main/banner.sh"
response=$(curl -s $url)

# Deleting first line which clears server_name variable
modified_response=$(echo "$response" | sed '1d')

output=$(echo "$modified_response")

echo "$output" > /etc/ssh/banner.txt

echo "Banner /etc/ssh/banner.txt" >> /etc/ssh/sshd_config
