#!/bin/bash -x

ONEC_VERSION=$1

if [ -d "/opt/1C/v8.3/x86_64" ] ; then 
     echo "Create link for /opt/1C/v8.3/x86_64/"
     ln -s /opt/1C/v8.3/x86_64/1cestart /usr/local/bin/1cestart
     ln -s /opt/1C/v8.3/x86_64/1cv8 /usr/local/bin/1cv8
     ln -s /opt/1C/v8.3/x86_64/ras /usr/local/bin/ras
     ln -s /opt/1C/v8.3/x86_64/rac /usr/local/bin/rac

elif  [ -d "/opt/1cv8/x86_64/$ONEC_VERSION" ] ; then 
     echo "Create link for /opt/1cv8/x86_64/$ONEC_VERSION"
     ln -s /opt/1cv8/x86_64/$ONEC_VERSION/1cestart /usr/local/bin/1cestart
     ln -s /opt/1cv8/x86_64/$ONEC_VERSION/1cv8 /usr/local/bin/1cv8
     ln -s /opt/1cv8/x86_64/$ONEC_VERSION/ras /usr/local/bin/ras
     ln -s /opt/1cv8/x86_64/$ONEC_VERSION/rac /usr/local/bin/rac
else 
    echo "onec not found"
    exit 1
fi
