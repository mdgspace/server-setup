html_content=$(curl -s $webpage_url)

modified_html_content=$(echo "$html_content" | sed "s/<bold id=\"#name\"><\/bold>/<bold id=\"#name\">$server_name<\/bold>/g")

# Create the new webpage
sudo sh -c "echo '$modified_html_content' > $webpage_path"

echo "Webpage created at $webpage_path"
