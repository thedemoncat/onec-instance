#!/bin/bash

# Hostname to add/remove.
# HOSTNAME=$(grep HOSTNAME .env | xargs)
export $(grep -v '^#' .env | xargs)

# onec-full
mkdir ./onec-full/distrib/
cp ./distrib/* ./onec-full/distrib/

docker build -t ghcr.io/thedemoncat/onec-full:${ONEC_VERSION} --build-arg ONEC_VERSION=$ONEC_VERSION ./onec-full

rm -rf ./onec-full/distrib

# onec-server
mkdir ./onec-server/distrib/
cp ./distrib/* ./onec-server/distrib/

docker build -t ghcr.io/thedemoncat/onec-server:8.3.21.1302 --build-arg ONEC_VERSION=$ONEC_VERSION ./onec-server

rm -rf ./onec-server/distrib/
