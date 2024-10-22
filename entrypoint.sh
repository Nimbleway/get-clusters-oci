#!/bin/bash

if [ $GET_ALL = true ]; then
  CLUSTERS=$(oci ce cluster list --compartment-id ocid1.compartment.oc1..aaaaaaaafnrvqjgsvwytt42sx6mxrmg7xcedrn36akmytcq2pjh4uir2puja --lifecycle-state ACTIVE --query "data[].id")
else
  CLUSTERS=$(oci ce cluster list --compartment-id $COMPARTMENT_ID --lifecycle-state ACTIVE --query "data[?contains(\"name\",'$CLUSTER_NAME')] | [?contains(\"name\",'$ENVIRONMENT')] .id")
fi

echo $CLUSTERS
echo "ocids=$(echo $CLUSTERS)" >> $GITHUB_OUTPUT
