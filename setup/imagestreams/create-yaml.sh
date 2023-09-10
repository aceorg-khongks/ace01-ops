#!/bin/bash

export ACE_IMAGE=cp.icr.io/cp/appc/ace-server-prod@sha256:246828d9f89c4ed3a6719cd3e4b71b1dec382f848c9bf9c28156f78fa05bc4e7
envsubst < setup/imagestreams/imagestream.yaml.tmpl >> setup/imagestreams/imagestream.yaml
oc apply -f setup/imagestreams/imagestream.yaml