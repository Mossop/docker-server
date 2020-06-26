# build = { "image": "mossop/php-fpm" }
FROM mossop/alpine-build

ARG VERSION=7.4.7

ENV PHPCFLAGS="-fstack-protector-strong -fpic -fpie"
ENV PHPLDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

COPY init /init/

RUN /usr/src/installers/install-libpq && \
    CFLAGS="$PHPCFLAGS $CFLAGS" \
    CPPFLAGS="$CFLAGS" \
    LDFLAGS="$PHPLDFLAGS $LDFLAGS" \
    mkusr php /var/www 2401 && \
    addgroup php www-data && \
    mkdir -p /etc/php/conf.d && \
    apk-begin .builddeps \
      autoconf \
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
      libzip-dev \
      libwebp-dev \
      jpeg-dev \
      libpng-dev \
      libxpm-dev \
      re2c \
      bison \
      freetype-dev \
      sqlite-dev \
      oniguruma-dev && \
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
      --with-pgsql \
      --with-bz2 \
      --with-zip \
      --with-password-argon2 \
      --with-sodium \
      --with-curl \
      --with-libedit \
      --with-openssl \
      --with-zlib \
      --enable-gd \
      --with-webp \
      --with-jpeg \
      --with-zlib-dir=/usr/include \
      --with-xpm \
      --with-freetype \
      --enable-pcntl \
      --enable-fpm \
      --with-fpm-user=php \
      --with-fpm-group=www-data \
      --disable-cgi \
      --with-pear && \
    make && \
    mkdir -p /usr/src/build /usr/local/include && \
    make INSTALL_ROOT=/usr/src/build install && \
    cp -a /usr/src/build/usr/local/include/php /usr/local/include/php && \
    cp /usr/src/build/usr/local/bin/php-config /usr/local/bin/php-config && \
    strip-build build && \
    install-build build && \
    cp /usr/src/php/php.ini-production /etc/php/php.ini && \
    pecl channel-update pecl.php.net && \
    apk-end .builddeps && \
    mv /etc/php-fpm.d/www.conf.default /etc/php-fpm.d/www.conf && \
    mv /etc/php-fpm.conf.default /etc/php-fpm.conf && \
    rm -rf /usr/src/php && \
    echo "zend_extension=opcache.so" >>/etc/php/php.ini && \
    echo "opcache.enabled=1" >> /etc/php/php.ini

COPY etc/php-fpm.d/* /etc/php-fpm.d/

EXPOSE 9000

CMD ["/init/init"]
