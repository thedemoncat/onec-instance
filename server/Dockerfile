FROM alpine:latest as downloader

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG VERSION
ENV installer_type=server

RUN apk --no-cache add bash curl grep \
  && cd /tmp \
  && curl -O "https://git.oskk.1solution.ru/RIZhdanov/downloader/raw/EDT/download.sh" \
  && chmod +x download.sh \
  && sync; ./download.sh \
  && for file in *.tar.gz; do tar -zxf "$file"; done \
  && rm -rf *.tar.gz

FROM demoncat/onec-base:latest as base
LABEL maintainer="Ruslan Zhdanov <nl.ruslan@yandex.ru> (@TheDemonCat)"

COPY --from=downloader /tmp/*.deb /tmp/

RUN set -xe \
    && cd /tmp \
    && dpkg -i ./1c-enterprise83-common_*.deb \
        ./1c-enterprise83-server_*.deb \
        ./1c-enterprise83-ws_*.deb \
        ./1c-enterprise83-crs_*.deb \
    && cd .. \
    && rm -rf /tmp/*

RUN mkdir -p /root/.1cv8/1C/1cv8/conf/

EXPOSE 1541/tcp
EXPOSE 1560-1591/tcp

COPY ./configs/conf.cfg /opt/1C/v8.3/x86_64/conf/
COPY ./scripts/srv1cv83 /etc/init.d/srv1cv83

COPY ./configs/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf

USER usr1cv8 

RUN mkdir /home/usr1cv8/srvinfo 

CMD ["/opt/1C/v8.3/x86_64/ragent", "-debug", "-d",  "/home/usr1cv8/srvinfo"]