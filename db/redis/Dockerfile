# build = { "image": "mossop/redis" }
FROM mossop/alpine-build

ARG VERSION=5.0.4

RUN mkusr nginx /var/www 2301 && \
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
    apk-end .builddeps

COPY redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["redis-server"]
