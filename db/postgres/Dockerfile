# build = { "image": "mossop/postgres" }
FROM mossop/alpine-build

ARG VERSION=12.1

RUN /usr/src/installers/install-locales && \
    mkusr postgres /var/www 2601 && \
    apk-add \
      su-exec && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      readline-dev \
      zlib-dev && \
    conf-build "https://ftp.postgresql.org/pub/source/v${VERSION}/postgresql-${VERSION}.tar.bz2" && \
    apk-end .builddeps && \
    rm -rf /usr/src && \
    mkdir -p /usr/local/pgsql/data

COPY init /init/

EXPOSE 5432/tcp

CMD ["/init/init"]
