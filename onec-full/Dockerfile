FROM demoncat/onec-base:latest as base
LABEL maintainer="Ruslan Zhdanov <nl.ruslan@yandex.ru> (@TheDemonCat)"

ARG TYPE=platform83

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION
ARG TYPE=platform83

ARG ONEGET_VER=v0.5.2
WORKDIR /tmp

RUN set -xe; \
  apt update; \
  apt install -y \ 
    curl \
    bash \
    gzip; \
    rm -rf /var/lib/apt/lists/*

COPY distrib /tmp/downloads/$TYPE/$ONEC_VERSION/

RUN  set -xe; \
  ls -la;\ 
  cd /tmp/downloads/$TYPE/$ONEC_VERSION/; \ 
  ./setup-full-$ONEC_VERSION-x86_64.run --mode unattended  --enable-components client_thin,ws,server_admin,server  --installer-language en; \
  cd /tmp; \
  rm -rf downloads

COPY ./scripts/create_symlink.sh create_symlink.sh

RUN set -e \
  && chmod +x create_symlink.sh \
  && ./create_symlink.sh $ONEC_VERSION