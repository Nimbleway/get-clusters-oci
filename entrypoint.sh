#!/bin/bash
if ! command -v oci &> /dev/null
then
    echo "OCI CLI not found, installing..."
    # Install OCI CLI
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
else
    echo "OCI CLI is already installed"
fi


GET_ALL="${GET_ALL:-false}"

if [ $GET_ALL = true ]; then
  CLUSTERS=$(oci ce cluster list --compartment-id $COMPARTMENT_ID --lifecycle-state ACTIVE --query "data[].id")
  str=$(echo $CLUSTERS | tr -d '"' | tr -d '\' | tr -d '[' | tr -d ']')
  IFS=$'\n' read -r -d '' -a MODIFY <<< $str
  RESULT=$(jq -n '$ARGS.positional' --args "${MODIFY[@]}")
  echo $RESULT
  echo "ocids=$(echo $RESULT)" >> $GITHUB_OUTPUT
else
  CLUSTERS=$(oci ce cluster list --compartment-id $COMPARTMENT_ID --lifecycle-state ACTIVE --query "data[?contains(\"name\",'$CLUSTER_NAME')] | [?contains(\"name\",'$ENVIRONMENT')] .id")
  str=$(echo $CLUSTERS | tr -d '"' | tr -d '\' | tr -d '[' | tr -d ']')
  IFS=$'\n' read -r -d '' -a MODIFY <<< $str
  RESULT=$(jq -n '$ARGS.positional' --args "${MODIFY[@]}")
  echo $RESULT
  echo "ocids=$(echo $RESULT)" >> $GITHUB_OUTPUT
fi
