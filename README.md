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


# New version
git tag x.x.x
git push --tags
