#!/bin/bash
set -e

TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token) 
CURL_CA_BUNDLE=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt 

cd /tmp

if [[ -v KUBE_NAMESPACE ]]; then
    if [ -f onec-server.json]; then
        rm onec-server.json
    fi
    curl --cacert "$CURL_CA_BUNDLE" \
    --header "Authorization: Bearer $TOKEN"  \
    https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT_HTTPS}/api/v1/namespaces/${KUBE_NAMESPACE}/pods?labelSelector=app%3Donec-server >> onec-server.json

    for k in $(jq '.items | keys | .[]'  onec-server.json); do
        value=$(jq -r ".items[$k]"  onec-server.json);
        podName=$(jq -r '.metadata.name' <<< "$value");
        podIP=$(jq -r '.status.podIP' <<< "$value");
        echo "$podIP $podName" >> /etc/hosts
    done | column -t -s$'\t'

    rm onec-server.json
fi
