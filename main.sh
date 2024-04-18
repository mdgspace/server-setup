#!/bin/bash

# Redirect stdout and stderr to both console and log file
exec > >(tee -i "setup.log") 2>&1

source scripts/config.sh
source scripts/install.sh
source scripts/iam.sh
source scripts/webpage.sh
source scripts/shell.sh
source scripts/verify.sh

echo "Setup script executed successfully"
