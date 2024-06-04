#!/bin/bash
chmod +x ./setup-oci-cli.sh
./setup-oci-cli.sh

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
