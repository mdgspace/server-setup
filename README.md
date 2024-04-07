# Server Setup

Script to setup ec2 instances for `mdgspace`

## Development

1. Run `find . -type f -name "*.sh" -exec chmod +x {} \;` to make all scripts executable
2. Run `./main.sh` to test the script
3. Run `./build.sh` to build the setup script

## Usage

1. Copy the content of `setup.sh`
2. Run `nano setup.sh` in the server, paste the content and save
3. Run `chmod +x setup.sh` to make the script executable
4. Run `./setup.sh` to setup the server
