# build = { "image": "mossop/mysql" }
FROM mossop/alpine-build

ARG VERSION=8.0.20

RUN mkusr mysql /var/lib/mysql 3001 && \
    apk-add openssl && \
    apk-begin .builddeps \
      build-base \
      cmake \
      openssl-dev \
      ncurses-dev \
      libtirpc-dev \
      rpcgen \
      linux-headers && \
    get-source mysql "https://dev.mysql.com/get/Downloads/MySQL-${VERSION}/mysql-boost-${VERSION}.tar.gz" && \
    mkdir -p /usr/src/build && \
    cd /usr/src/build && \
    cmake \
      -DBUILD_CONFIG=mysql_release \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE=Release \
      -DSYSCONFDIR=/etc/mysql \
      -DMYSQL_DATADIR=/var/lib/mysql \
      -DWITH_DEBUG=false \
      -DWITH_BOOST=/usr/src/mysql/boost \
      ../mysql && \
    make && \
    mkdir -p /usr/src/built && \
    make DESTDIR=/usr/src/built install && \
    strip-build built && \
    install-build built && \
    apk-end .builddeps

COPY init /init/

EXPOSE 3306/tcp

CMD ["/init/init"]
