# build = { "image": "mossop/php-fpm" }
FROM mossop/alpine-build

ARG VERSION=7.3.3

ENV PHPCFLAGS="-fstack-protector-strong -fpic -fpie"
ENV PHPLDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

RUN CFLAGS="$PHPCFLAGS $CFLAGS" \
    CPPFLAGS="$CFLAGS" \
    LDFLAGS="$PHPLDFLAGS $LDFLAGS" \
    mkusr php /var/www 2401 && \
    addgroup php www-data && \
    mkdir -p /etc/php/conf.d && \
    apk-begin .builddeps \
      curl \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      libxml2-dev \
      openssl-dev \
      bzip2-dev \
      curl-dev \
      libedit-dev \
      libsodium-dev \
      argon2-dev \
      libzip-dev && \
    set -e && \
    mkdir -p /usr/src/php && \
    curl -L -s "https://secure.php.net/get/php-$VERSION.tar.xz/from/this/mirror" | \
      tar -xJf - -C /usr/src/php --strip-components=1 && \
    cd /usr/src/php && \
    ./configure \
      --sysconfdir=/etc \
      --with-config-file-path="/etc/php" \
      --with-config-file-scan-dir="/etc/php/conf.d" \
      --enable-option-checking=fatal \
      --with-mhash \
      --enable-ftp \
      --enable-mbstring \
      --enable-mysqlnd \
      --with-mysqli \
      --with-bz2 \
      --enable-zip \
      --with-password-argon2 \
      --with-sodium \
      --with-curl \
      --with-libedit \
      --with-openssl \
      --with-zlib \
      --enable-fpm \
      --with-fpm-user=php \
      --with-fpm-group=www-data \
      --disable-cgi && \
    make && \
    mkdir -p /usr/src/build && \
    make INSTALL_ROOT=/usr/src/build install && \
    strip-build build && \
    install-build build && \
    apk-end .builddeps && \
    cp /usr/src/php/php.ini-* /etc/php && \
    mv /etc/php-fpm.d/www.conf.default /etc/php-fpm.d/www.conf && \
    mv /etc/php-fpm.conf.default /etc/php-fpm.conf && \
    rm -rf /usr/src/php

COPY etc/php-fpm.d/* /etc/php-fpm.d/

EXPOSE 9000

CMD ["php-fpm"]
