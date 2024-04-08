html_page_url="https://raw.githubusercontent.com/mdgspace/server-setup/master/index.html"

# TODO: ask server name from user
server_name="Jupyter"

webpage_path="./test.html"

html_content=$(curl -s $html_page_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

echo "$modified_html_content" > $webpage_path
