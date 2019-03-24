# build = { "image": "mossop/redis" }
FROM mossop/alpine-build

ARG VERSION=5.0.4

RUN mkusr redis /var/lib/redis 2301 && \
    apk-add su-exec && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev && \
    get-source redis "http://download.redis.io/releases/redis-${VERSION}.tar.gz" && \
    set -x && \
    cd /usr/src/redis && \
    make && \
    mkdir -p /usr/src/build && \
    make PREFIX=/usr/src/build/usr/local install && \
    rm -rf /usr/src/redis && \
    set +x && \
    strip-build build && \
    install-build build && \
    apk-end .builddeps && \
    mkdir -p /var/lib/redis && \
    chown redis:redis /var/lib/redis

COPY redis.conf /etc/redis.conf

COPY bin/* /usr/local/bin/

EXPOSE 6379

CMD ["/usr/local/bin/init"]
