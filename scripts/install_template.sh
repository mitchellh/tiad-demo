#!/bin/bash
set -e

echo "Fetching consul-template..."
cd /tmp
wget https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz -O ct.tar.gz

echo "Installing consul-template..."
tar xvzf ct.tar.gz >/dev/null
cd consul-template**
sudo mv consul-template /usr/local/bin/consul-template

echo "Installing Upstart service..."
sudo mv /tmp/upstart.conf /etc/init/consul-template.conf
