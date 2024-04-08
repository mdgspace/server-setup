#!/bin/bash

echo "Execution started (main.sh)"

# region scripts/config.sh
echo "Execution started (config.sh)"

echo "Please enter server name:"
read server_name

echo "Execution completed (config.sh)"
# endregion scripts/config.sh

# region scripts/install.sh
echo "Execution started (install.sh)"

echo "Execution completed (install.sh)"
# endregion scripts/install.sh

# region scripts/webpage.sh
html_page_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/index.html"

# TODO: Modify the path to www
webpage_path="./test.html"

html_content=$(curl -s $html_page_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

echo "$modified_html_content" > $webpage_path

echo "Webpage created at $webpage_path"
# endregion scripts/webpage.sh


echo "Execution completed (main.sh)"
