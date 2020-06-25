# build = { "image": "mossop/bind" }
FROM mossop/alpine-build

ARG VERSION=9.16.4

COPY init /init/

RUN mkusr named /etc/named 2701 && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      openssl-dev \
      libcap-dev \
      libuv-dev && \
    rm /var/run && \
    conf-build "https://downloads.isc.org/isc/bind9/${VERSION}/bind-${VERSION}.tar.xz" \
      --without-python \
      --disable-symtable && \
    set -x && \
    apk-end .builddeps && \
    mkdir -p /etc/named

EXPOSE 53

CMD ["/init/init"]
