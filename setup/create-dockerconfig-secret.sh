#!/bin/bash

# need to export IBM_ENTITLEMENT_KEY
NAMESPACE=${1:-ace01-ci}

IMAGE_REGISTRY_SERVICE_URL=image-registry.openshift-image-registry.svc.cluster.local:5000
IMAGE_REGISTRY_SERVICE_AUTH_B64=$(echo $(oc whoami):$(oc whoami -t) | base64)
IBM_ENTITLEMENT_AUTH_B64=$(echo cp:${IBM_ENTITLEMENT_KEY} | base64)

cat <<EOF > config.json
{
  "auths" : {
    "${IMAGE_REGISTRY_SERVICE_URL}" : {
      "auth": ${IMAGE_REGISTRY_SERVICE_AUTH_B64}
    },
    "cp.icr.io" : {
      "auth": ${IBM_ENTITLEMENT_AUTH_B64}
    }
  }
}
EOF

cat <<EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dockerconfig-secret
  namespace: ${NAMESPACE}
data:
  config.json: $(cat config.json | base64)
EOF