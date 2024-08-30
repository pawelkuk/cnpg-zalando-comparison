# CNPG/zalando operator comparison

## Setup

### Local cluster

1. Multinode cluster:

   `kind create cluster --name cnpg-zalando-comparison --config kind.yaml`

2. Kind cloud provider to make loadBalancer type services work:

   `go install sigs.k8s.io/cloud-provider-kind@latest && sudo cloud-provider-kind`
