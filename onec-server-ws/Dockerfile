ARG ONEC_VERSION

FROM ghcr.io/thedemoncat/onec-server:$ONEC_VERSION

LABEL org.opencontainers.image.authors="Ruslan Zhdanov <nl.ruslan@yandex.ru> (@TheDemonCat)"
LABEL org.opencontainers.image.source="https://github.com/thedemoncat/onec-server-ws"

USER root

ARG ONEC_VERSION
ENV ONEC_VERSION=$ONEC_VERSION
RUN set -xe \
    && apt update \
    &&  apt install -y --no-install-recommends apache2 \ 
    && sed -i '/#ServerName www.example.com/ s//ServerName localhost/g' /etc/apache2/sites-enabled/000-default.conf \
    && echo ServerName 127.0.0.1 >> /etc/apache2/apache2.conf \
    && ln -s /opt/1cv8/x86_64/$ONEC_VERSION/webinst /usr/bin/webinst 

EXPOSE 1550
ENV DBGS_ADDR 127.0.0.1

ADD ./entrypoint.sh /
 
RUN chown usr1cv8 /entrypoint.sh && \
  chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]