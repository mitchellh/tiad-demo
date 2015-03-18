#!/bin/bash
set -e

# Read from the file we created for various things
SERVER_COUNT=$(cat /tmp/consul-server-count | tr -d '\n')
ATLAS_APP=$(cat /tmp/atlas-app | tr -d '\n')
ATLAS_TOKEN=$(cat /tmp/atlas-token | tr -d '\n')

# Write the flags to a temporary file
cat >/tmp/consul_flags << EOF
export CONSUL_FLAGS="-server -bootstrap-expect=${SERVER_COUNT} -client=0.0.0.0 -data-dir=/mnt/consul -atlas=${ATLAS_APP} -atlas-token=${ATLAS_TOKEN} -atlas-join"
EOF

# Write it to the full service file
sudo mv /tmp/consul_flags /etc/service/consul
chmod 0644 /etc/service/consul
