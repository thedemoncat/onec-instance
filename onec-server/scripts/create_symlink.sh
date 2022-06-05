#!/bin/bash -x

ONEC_VERSION=$1

if [ -f /opt/1C/v8.3/x86_64/ragent ] ; then 
    echo "Create link for /opt/1C/v8.3/x86_64/ragent"
    ln -s /opt/1C/v8.3/x86_64/ragent /usr/local/bin/ragent
elif [ -f "/opt/1cv8/x86_64/$ONEC_VERSION/ragent" ]; then 
    echo "Create link for /opt/1cv8/x86_64/$ONEC_VERSION"
    ln -s "/opt/1cv8/x86_64/$ONEC_VERSION/ragent" /usr/local/bin/ragent
else 
    echo "ragent not found"
    exit 1
fi
