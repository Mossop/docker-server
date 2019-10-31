# build = { "image": "mossop/rspamd" }
FROM mossop/alpine-build

ARG VERSION=2.1

RUN mkdir -p /var/lib/rspamd && \
    mkusr rspamd /var/lib/rspamd 2501 && \
    chown rspamd:rspamd /var/lib/rspamd && \
    apk-begin .builddeps \
      git \
      coreutils \
      make \
      cmake \
      gcc \
      g++ \
      linux-headers \
      pkgconf \
      musl-dev \
      ragel \
      perl \
      luajit-dev \
      glib-dev \
      libevent-dev \
      sqlite-dev \
      icu-dev \
      libsodium-dev \
      openssl-dev \
      file-dev && \
    cd /usr/src && \
    git clone --recursive https://github.com/rspamd/rspamd.git && \
    cd rspamd && \
    git checkout $VERSION && \
    mkdir /usr/src/build && \
    cd /usr/src/build && \
    cmake -DCONFDIR=/etc/rspamd ../rspamd && \
    make && \
    mkdir /usr/src/final && \
    DESTDIR=/usr/src/final make install && \
    rm -rf /usr/src/final/usr/local/share/examples /usr/src/final/usr/local/share/man && \
    strip-build final && \
    install-build final && \
    rm -rf /usr/src/rspamd /usr/src/build && \
    sed -i -e 's@localhost:@*:@' /etc/rspamd/rspamd.conf && \
    sed -i -e 's@type = "file";@type = "console";@' /etc/rspamd/rspamd.conf && \
    apk-end .builddeps

EXPOSE 11333

CMD ["rspamd", "-f", "-u", "rspamd", "-g", "rspamd"]
