FROM debian:12-slim AS builder
LABEL maintainer="Eddie Wang <eddie0501@foxmail.com>"

USER root

ENV DEBIAN_FRONTEND=noninteractive

ARG OPENSIPS_VERSION
ARG BUILD_MOD

COPY debian.sources /etc/apt/sources.list.d/

RUN apt-get update

ADD https://download.opensips.org/opensips-${OPENSIPS_VERSION}.tar.gz /usr/local/src/

RUN cd /usr/local/src/ && tar -zxvf opensips-${OPENSIPS_VERSION}.tar.gz
WORKDIR /usr/local/src/

RUN apt-get install --no-install-recommends -y build-essential \
    bison flex m4 pkg-config libncurses5-dev \
    libssl-dev default-libmysqlclient-dev libmicrohttpd-dev libcurl4-openssl-dev uuid-dev \
    libpcre3-dev libconfuse-dev libxml2-dev libhiredis-dev

RUN cd opensips-${OPENSIPS_VERSION} && \
    make include_modules="${BUILD_MOD}" modules

RUN cd opensips-${OPENSIPS_VERSION} && \
    make prefix=/usr/local install

RUN which opensips && opensips -h
RUN ldd /usr/local/sbin/opensips

FROM debian:12-slim

COPY debian.sources /etc/apt/sources.list.d/
RUN apt-get update && apt-get install --no-install-recommends -y m4 rsyslog \
    cron logrotate procps net-tools curl apt-transport-https ca-certificates netbase

RUN curl https://apt.opensips.org/opensips-org.gpg -o /usr/share/keyrings/opensips-org.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/opensips-org.gpg] https://apt.opensips.org bookworm cli-nightly" >/etc/apt/sources.list.d/opensips-cli.list && \
    apt-get -y update && apt-get -y install opensips-cli

COPY --from=builder /usr/local/sbin/opensips /usr/local/sbin/opensips
COPY --from=builder /usr/local/etc/opensips /usr/local/etc/opensips
COPY --from=builder /usr/local/lib64/opensips/modules /usr/local/lib64/opensips/modules
COPY entrypoint.sh /entrypoint.sh
COPY rsyslog.conf /etc/rsyslog.conf
COPY logrotate.conf /etc/logrotate.d/opensips

RUN chmod +x /entrypoint.sh && \
    mkdir /run/opensips && \
    touch /var/log/opensips.log && \
    echo "*/10 * * * * /usr/sbin/logrotate /etc/logrotate.d/opensips" >> /var/spool/cron/crontabs/root && \
    chmod 600 /var/spool/cron/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]
