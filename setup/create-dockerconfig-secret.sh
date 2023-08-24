#!/bin/bash

# need to export IBM_ENTITLEMENT_KEY
NAMESPACE=${1:-ace01-ci}

IMAGE_REGISTRY_SERVICE_AUTH_B64=$(echo -n "kubeadmin:$(oc whoami -t)" | base64)
IBM_ENTITLEMENT_AUTH_B64=$(echo -n cp:${IBM_ENTITLEMENT_KEY} | base64)

echo ${IMAGE_REGISTRY_SERVICE_AUTH_B64}
echo ${IBM_ENTITLEMENT_AUTH_B64}

cat <<EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dockerconfig-secret
  namespace: ${NAMESPACE}
stringData:
  config.json: |
    {
      "auths" : {
        "image-registry.openshift-image-registry.svc:5000" : {
          "auth": "${IMAGE_REGISTRY_SERVICE_AUTH_B64}"
        },
        "image-registry.openshift-image-registry.svc.cluster.local:5000" : {
          "auth": "${IMAGE_REGISTRY_SERVICE_AUTH_B64}"
        },
        "cp.icr.io" : {
          "auth": "${IBM_ENTITLEMENT_AUTH_B64}"
        }
      }
    }
EOF

# cat <<EOF | oc apply -f -
# apiVersion: v1
# kind: Secret
# metadata:
#   name: dockerconfig-secret
#   namespace: ${NAMESPACE}
# stringData:
#   config.json: |
#     {
#       "auths" : {
#         "image-registry.openshift-image-registry.svc.cluster.local:5000" : {
#           "auth": "${IMAGE_REGISTRY_SERVICE_AUTH_B64}"
#         }
#       }
#     }
# EOF