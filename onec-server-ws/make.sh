#!/bin/bash

if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

IMAGE_NAME_SERVER=${1:-"ghcr.io/thedemoncat/onec-server"}
IMAGE_NAME_SERVER_WS=${1:-"ghcr.io/thedemoncat/onec-server-ws"}

env=()
while IFS= read -r line || [[ "$line" ]]; do
  env+=("$line")
done < ONEC_VERSION
 
curl https://github.com/thedemoncat/onec-server/archive/refs/heads/master.zip -o onec-server.zip
unzip  onec-server.zip
rm -f onec-server.zip

for item in ${env[*]}
do
  docker build -t $IMAGE_NAME_SERVER:"$item" \
      --build-arg ONEC_USERNAME="$ONEC_USERNAME" \
      --build-arg ONEC_PASSWORD="$ONEC_PASSWORD"  \
      --build-arg ONEC_VERSION="$item" ./onec-server-master

  echo $IMAGE_NAME_SERVER_WS:"$item"
  docker build -t $IMAGE_NAME_SERVER_WS:"$item" \
      --build-arg ONEC_VERSION="$item" .

done
