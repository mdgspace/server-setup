sudo usermod -aG docker $USER

password=$(< /dev/urandom tr -dc '[:alnum:]' | head -c12)
sudo adduser --disabled-password --gecos "" developers
echo "developers:$password" | sudo chpasswd
sudo usermod -aG docker developers

# Generate a new key pair
ssh-keygen -t rsa -b 2048 -f temp_rsa_key -N ""
PUBLIC_KEY=$(cat temp_rsa_key.pub)
PRIVATE_KEY=$(cat temp_rsa_key)

rm temp_rsa_key temp_rsa_key.pub

sudo mkdir /home/developers/.ssh
sudo chown developers:developers /home/developers/.ssh
sudo chmod 700 /home/developers/.ssh

echo "ssh info for developers (non root users):"
echo "------Copy the following private key and save it in a secure place------"
echo $PRIVATE_KEY
echo "----------------------------------------------------------------------"

sudo sh -c "echo $PUBLIC_KEY >> /home/developers/.ssh/authorized_keys"
sudo chown developers:developers /home/developers/.ssh/authorized_keys
sudo chmod 600 /home/developers/.ssh/authorized_keys
