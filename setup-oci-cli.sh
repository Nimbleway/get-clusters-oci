#!/bin/bash

# Check if OCI CLI is installed
if ! command -v oci &> /dev/null
then
    echo "OCI CLI not found, installing..."
    # Install OCI CLI
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
else
    echo "OCI CLI is already installed"
fi
