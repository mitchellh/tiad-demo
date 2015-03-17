#!/bin/bash
set -e

# Write the flags to a temporary file
cat >/tmp/consul_flags << EOF
export CONSUL_FLAGS="-data-dir=/mnt/consul"
EOF

# Write it to the full service file
sudo mv /tmp/consul_flags /etc/service/consul
chmod 0644 /etc/service/consul
