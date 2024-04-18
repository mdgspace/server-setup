# Verify Installation

# snapd
if ! command -v snap &> /dev/null; then
  echo "snapd is not installed"
fi

# git
if ! command -v git &> /dev/null; then
  echo "git is not installed"
fi

# docker
if ! command -v docker &> /dev/null; then
  echo "docker is not installed"
fi

# nginx
if ! command -v nginx &> /dev/null; then
  echo "nginx is not installed"
fi

# certbot
if ! command -v certbot &> /dev/null; then
  echo "certbot is not installed"
fi

# Verify User
if ! id -u developers &>/dev/null; then
  echo "non root user 'developers' is not created"
fi

if [ ! -f /home/developers/.ssh/authorized_keys ]; then
  echo "SSH key for developers is not created"
fi

# Verify Configuration
if [ ! -f /var/www/html/index.html ]; then
  echo "webpage is not created"
fi
