sudo usermod -aG docker $USER
sudo adduser stargazers
sudo usermod -aG docker stargazers

# Copy the public key to the new user
sudo mkdir /home/stargazers/.ssh
sudo chown stargazers:stargazers /home/stargazers/.ssh
sudo chmod 700 /home/stargazers/.ssh

echo "Provide the public key for non sudo user (stargazers)"
read PUBLIC_KEY

sudo sh -c "echo $PUBLIC_KEY >> /home/stargazers/.ssh/authorized_keys"
sudo chown stargazers:stargazers /home/stargazers/.ssh/authorized_keys
sudo chmod 600 /home/stargazers/.ssh/authorized_keys
