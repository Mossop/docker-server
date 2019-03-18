FROM mossop/alpine

RUN set -ex && \
    apk-begin .build-deps \
      curl \
      gcc \
      make \
      libc-dev \
      linux-headers \
      openssl-dev \
      lzo-dev \
      linux-pam-dev && \
    conf-build https://swupdate.openvpn.org/community/releases/openvpn-2.4.7.tar.xz && \
    apk-end .build-deps && \
    add-deps && \
    mkdir -p /etc/openvpn && \
    mkdir -p /var/openvpn/pid

COPY bin/* /usr/local/bin/

EXPOSE 1194

CMD ["/usr/local/bin/init"]
