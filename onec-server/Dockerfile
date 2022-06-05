FROM demoncat/onec-base:latest as base

LABEL org.opencontainers.image.authors="Ruslan Zhdanov <nl.ruslan@yandex.ru> (@TheDemonCat)"
LABEL org.opencontainers.image.source="https://github.com/thedemoncat/onec-server"

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION
ARG TYPE=platform83

ARG ONEGET_VER=v0.5.2

RUN set -xe; \
  apt update; \
  apt install -y \ 
    curl \
    bash \
    gzip \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    geoclue-2.0; \
    rm -rf /var/lib/apt/lists/*

#start_oneget

COPY distrib /tmp/downloads/$TYPE/$ONEC_VERSION/

RUN  set -xe; \
  ls -la;\ 
  cd /tmp/downloads/$TYPE/$ONEC_VERSION/; \ 
  ./setup-full-$ONEC_VERSION-x86_64.run --mode unattended  --enable-components ws,server_admin,server  --installer-language en; \
  cd /tmp; \
  rm -rf /tmp/onec
#end_oneget

EXPOSE 1540-1541 1545 1550 1560-1591

COPY ./configs /opt/1C/v8.3/x86_64/$ONEC_VERSION/conf
COPY ./scripts/srv1cv83 /etc/init.d/srv1cv83

COPY ./scripts/create_symlink.sh ./create_symlink.sh
COPY entrypoint.sh ./entrypoint.sh

RUN set -e \
  && chmod +x ./create_symlink.sh \
  && chmod +x ./entrypoint.sh \
  && ./create_symlink.sh $ONEC_VERSION

USER usr1cv8 

RUN mkdir /home/usr1cv8/srvinfo 

ENV ONEC_DATA=/home/usr1cv8/srvinfo

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "-debug", "-http" ]
