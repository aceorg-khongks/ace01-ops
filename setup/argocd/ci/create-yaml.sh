#!/bin/bash

## export GITORG=xxxxx

envsubst < setup/ci/argocd/ace01.yaml.tmpl >> environments/ci/argocd/ace01.yaml
oc apply -f environments/ci/argocd/ace01.yaml