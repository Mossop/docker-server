FROM mossop/alpine

ARG VERSION=2.4.7

RUN apk-begin .build-deps \
      gcc \
      make \
      libc-dev \
      linux-headers \
      openssl-dev \
      lzo-dev \
      linux-pam-dev && \
    conf-build https://swupdate.openvpn.org/community/releases/openvpn-$VERSION.tar.xz && \
    apk-end .build-deps && \
    mkdir -p /etc/openvpn && \
    mkdir -p /var/openvpn/pid

COPY bin/* /usr/local/bin/

EXPOSE 1194

CMD ["/usr/local/bin/init"]
