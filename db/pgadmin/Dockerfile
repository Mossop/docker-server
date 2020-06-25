# build = { "image": "mossop/pgadmin" }
FROM mossop/alpine-build

ARG VERSION=4.22

RUN /usr/src/installers/install-python3 && \
    /usr/src/installers/install-libpq && \
    get-source pgadmin "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${VERSION}/source/pgadmin4-${VERSION}.tar.gz" && \
    cd /usr/src/pgadmin && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      libffi-dev \
      openssl-dev && \
    pip3 install -r requirements.txt && \
    apk-add \
      musl-dev \
      binutils && \
    pip3 install gunicorn && \
    apk-end .builddeps

COPY config_local.py /usr/src/pgadmin/web/
COPY init /init/

EXPOSE 80/tcp

CMD ["/init/init"]
