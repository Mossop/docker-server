# build = { "image": "mossop/opendkim" }
FROM mossop/alpine-build

ARG VERSION=2.10.3

RUN mkdir -p /usr/src
COPY *.patch /usr/src/
COPY init /init/

RUN mkdir -p /var/lib/dkim && \
    mkusr dkim /var/lib/dkim 2601 && \
    chown dkim:dkim /var/lib/dkim && \
    mkdir -p /var/run/opendkim && \
    apk add \
      perl \
      openssl && \
    apk-begin .builddeps \
      git \
      coreutils \
      m4 \
      make \
      cmake \
      patch \
      gcc \
      g++ \
      linux-headers \
      pkgconf \
      musl-dev \
      openssl-dev \
      libbsd-dev \
      autoconf \
      automake \
      libmilter-dev && \
    get-source opendkim "https://sourceforge.net/projects/opendkim/files/opendkim-${VERSION}.tar.gz/download" && \
    cd /usr/src/opendkim && \
    cat ../openssl.patch | patch -p0 && \
    autoconf && \
    aclocal && \
    automake && \
    build-package opendkim target && \
    strip-build target && \
    install-build target && \
    apk-end .builddeps && \
    mkdir -p /etc/opendkim

WORKDIR /etc/opendkim/keys

EXPOSE 12301

CMD ["/init/init"]
