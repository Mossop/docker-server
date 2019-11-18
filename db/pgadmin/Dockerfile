# build = { "image": "mossop/pgadmin" }
FROM mossop/alpine-build

ARG VERSION=4.15
ARG POSTGRES_VERSION=12.1

RUN /usr/src/installers/install-python3 && \
    get-source pgadmin "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${VERSION}/source/pgadmin4-${VERSION}.tar.gz" && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      readline-dev \
      zlib-dev \
      libffi-dev \
      openssl-dev && \
    get-source postgres-src "https://ftp.postgresql.org/pub/source/v${POSTGRES_VERSION}/postgresql-${POSTGRES_VERSION}.tar.bz2" && \
    build-package postgres-src postgres && \
    cd /usr/src/pgadmin && \
    PATH=$PATH:/usr/src/postgres/usr/local/bin pip3 install -r requirements.txt && \
    cp /usr/src/postgres/usr/local/lib/libpq.so* /usr/local/lib && \
    rm -rf /usr/src/postgres && \
    apk-end .builddeps && \
    apk-add \
      musl-dev \
      binutils && \
    pip3 install gunicorn

COPY config_local.py /usr/src/pgadmin/web/
COPY init /init/

EXPOSE 80/tcp

CMD ["/init/init"]
