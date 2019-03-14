FROM alpine

RUN apk add --no-cache \
      lzo \
      lz4-dev \
      bash && \
    apk add --no-cache --virtual .build-deps \
      curl \
      gcc \
      make \
      libc-dev \
      linux-headers \
      openssl-dev \
      lzo-dev \
      linux-pam-dev && \
    mkdir -p /usr/src/openvpn && \
    cd /usr/src && \
    curl -o openvpn.tar.xz https://swupdate.openvpn.org/community/releases/openvpn-2.4.7.tar.xz && \
    tar -xJf openvpn.tar.xz -C /usr/src/openvpn --strip-components=1 && \
    rm openvpn.tar.xz && \
    cd openvpn && \
    ./configure && \
    make && \
    make install && \
    rm -rf /usr/src/openvpn && \
    cd / && \
    apk del --no-network .build-deps && \
    mkdir -p /etc/openvpn && \
    mkdir -p /var/openvpn/pid

COPY run.sh /usr/local/bin/

EXPOSE 1194

CMD ["run.sh"]
