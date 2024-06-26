#!/bin/bash
if ! command -v oci &> /dev/null
then
    echo "OCI CLI not found, installing..."
    # Install OCI CLI
    wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh
    sudo bash install.sh --accept-all-defaults --exec-dir /usr/local/bin
    mkdir -p ~/.oci
    echo [DEFAULT] >> ~/.oci/config
    echo user="$OCI_CLI_USER" >> ~/.oci/config
    echo fingerprint="$OCI_CLI_FINGERPRINT" >> ~/.oci/config
    echo key_file=~/.oci/oci_api_key.pem >> ~/.oci/config
    echo tenancy="$OCI_CLI_TENANCY" >> ~/.oci/config
    echo region="$OCI_CLI_REGION" >> ~/.oci/config
    echo "$OCI_CLI_KEY_CONTENT" >> ~/.oci/oci_api_key.pem
    oci setup repair-file-permissions --file ~/.oci/config
    oci setup repair-file-permissions --file ~/.oci/oci_api_key.pem    

else
    echo "OCI CLI is already installed"
fi


GET_ALL="${GET_ALL:-false}"

if [ $GET_ALL = true ]; then
  CLUSTERS=$(oci ce cluster list --compartment-id ocid1.compartment.oc1..aaaaaaaafnrvqjgsvwytt42sx6mxrmg7xcedrn36akmytcq2pjh4uir2puja --lifecycle-state ACTIVE --query "data[].id")
  #str=$(echo $CLUSTERS | tr -d '"' | tr -d '\' | tr -d '[' | tr -d ']')
  #IFS=$'\n' read -r -d '' -a MODIFY <<< $str
  #RESULT=$(jq -n '$ARGS.positional' --args "${MODIFY[@]}")
  echo $CLUSTERS
  echo "ocids=$(echo $CLUSTERS)" >> $GITHUB_OUTPUT
else
  CLUSTERS=$(oci ce cluster list --compartment-id $COMPARTMENT_ID --lifecycle-state ACTIVE --query "data[?contains(\"name\",'$CLUSTER_NAME')] | [?contains(\"name\",'$ENVIRONMENT')] .id")
  # str=$(echo $CLUSTERS | tr -d '"' | tr -d '\' | tr -d '[' | tr -d ']')
  # IFS=$'\n' read -r -d '' -a MODIFY <<< $str
  # RESULT=$(jq -n '$ARGS.positional' --args "${MODIFY[@]}")
  echo $CLUSTERS
  echo "ocids=$(echo $CLUSTERS)" >> $GITHUB_OUTPUT
fi
