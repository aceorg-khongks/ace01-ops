#!/bin/bash

## export GITUSER=xxxx
## export GITTOKEN=xxxx

NAMESPACE=${1:-ace01-ci}

GITCONFIG=$(printf "[credential \"https://github.com\"]\n  helper = store")
oc create secret generic gitcredentials-secret -n ${NAMESPACE} \
  --from-literal=.gitconfig="$GITCONFIG" \
  --from-literal=.git-credentials="https://$GITUSER:$GITTOKEN@github.com" \
  --type=Opaque \
  --dry-run=client -o yaml > ./gitcredentials-secret.yaml

oc apply -f ./gitcredentials-secret.yaml