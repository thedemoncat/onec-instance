#!/bin/bash
set -e

if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

IMAGE_NAME=${1:-"ghcr.io/thedemoncat/onec-full"}

env=()
while IFS= read -r line || [[ "$line" ]]; do
  env+=("$line")
done < ONEC_VERSION


for item in ${env[*]}
do
    OLD_VERSION_DIST=19
    echo "Собираем образ с версией платформы $item"
    if [ "$(echo $item | cut -d'.' -f3)" -gt "$OLD_VERSION_DIST" ]; then
        echo "С версии 8.3.20 и выше, дистрибутив установки изенился на run. Собираем по новой схеме сборки"
        docker build -t $IMAGE_NAME:"$item" \
            --build-arg ONEC_USERNAME="$ONEC_USERNAME" \
            --build-arg ONEC_PASSWORD="$ONEC_PASSWORD"  \
            --build-arg ONEC_VERSION="$item" .

        docker build -t $IMAGE_NAME:"$item"-k8s \
            --build-arg IMAGE_NAME="$IMAGE_NAME" \
            --build-arg ONEC_VERSION="$item" -f Dockerfile_k8s .
    else
        echo "Ниже версии 8.3.20, используется старая версия дистрибутивов (deb пакеты). Собираем по старой схеме сборки"
        docker build -t $IMAGE_NAME:"$item" \
            --build-arg ONEC_USERNAME="$ONEC_USERNAME" \
            --build-arg ONEC_PASSWORD="$ONEC_PASSWORD"  \
            --build-arg ONEC_VERSION="$item" 
            -f Dockerfile_deb.

        docker build -t $IMAGE_NAME:"$item"-k8s \
            --build-arg IMAGE_NAME="$IMAGE_NAME" \
            --build-arg ONEC_VERSION="$item" -f Dockerfile_k8s .
    fi 
done
