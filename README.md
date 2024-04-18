# Server Setup

Script to setup ec2 instances for `mdgspace`

## Development

1. Run `find . -type f -name "*.sh" -exec chmod +x {} \;` to make all scripts executable
2. Run `./main.sh` to test the script
3. Run `./build.sh` to build the setup script

## Usage

1. Download the setup script using one of the methods -
    - Copy the content of `setup.sh`. Run `nano setup.sh` in the server, paste the content and save
    - Run `wget https://raw.githubusercontent.com/mdgspace/server-setup/master/setup.sh`
    - Run `curl -o setup.sh https://raw.githubusercontent.com/mdgspace/server-setup/master/setup.sh`
2. Run `chmod +x setup.sh` to make the script executable
3. Run `./setup.sh` to setup the server
4. Remove the script and logs after inspecting the setup
5. Logout and login again to apply the changes
