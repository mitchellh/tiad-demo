#!/bin/bash
set -e

# Read from the file we created for various things
ATLAS_APP=$(cat /tmp/atlas-app | tr -d '\n')
ATLAS_TOKEN=$(cat /tmp/atlas-token | tr -d '\n')

# Write the flags to a temporary file
cat >/tmp/consul_flags << EOF
export CONSUL_FLAGS="-data-dir=/mnt/consul -atlas=${ATLAS_APP} -atlas-token=${ATLAS_TOKEN} -atlas-join"
EOF

# Write it to the full service file
sudo mv /tmp/consul_flags /etc/service/consul
chmod 0644 /etc/service/consul
