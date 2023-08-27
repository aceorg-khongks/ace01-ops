#!/bin/bash

## export GITORG=xxxxx

envsubst < setup/dev/argocd/ace01.yaml.tmpl >> environments/dev/argocd/ace01.yaml
oc apply -f environments/dev/argocd/ace01.yaml