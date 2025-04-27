# get-clusters-oci


This repo will find all k8s clusters with specific name and environment,
This will be used for ci/cd on multiple clusters.

## Environment Variables

| Variable              | Details                                                 | Example                                    |
|-----------------------|---------------------------------------------------------|--------------------------------------------|
| ENVIRONMENT           | Environment Name.                                       | `staging`                                  |
| CLUSTER_NAME          | Cluster Name.                                           | `foodies`                                    |
| GET_ALL               | Flag To Get All Clusters.                               | `true\false`                               |
| COMPARTMENT_ID        | Flag To Set Oracle Compartment Id.                      | `ocid.X`                                   |


# Exclude File
The file excluded_cluster_list.txt is used to exclude clusters from this action's output.
### Notice:
In the file make sure to write the excluded clusters in the form of a list (line per cluster) and NOT separated by spaces or commas! \
Good Example: \
oke-test1 \
oke-test2 

Bad example: \
oke-test1, oke-test2 oke-test3 

# New version
git tag x.x.x
git push --tags
