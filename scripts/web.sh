#!/bin/bash
set -e

# Install Apache
sudo apt-get update -y
sudo apt-get install -y apache2

# setup consul-template
sudo cp /tmp/web_content.ctmpl /mnt/web_content.ctmpl

# Write the flags to a temporary file
cat >/tmp/ct_flags << EOF
export CT_FLAGS="-template /mnt/web_content.ctmpl:/var/www/index.html"
EOF

# Write it to the full service file
sudo mv /tmp/ct_flags /etc/service/consul-template
chmod 0644 /etc/service/consul-template

# Start consul-template
echo "Starting consul-template..."
sudo start consul-template
