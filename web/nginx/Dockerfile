# build = { "image": "mossop/nginx" }
FROM mossop/alpine-build

ARG VERSION=1.19.0

RUN mkusr nginx /var/www 2201 && \
    addgroup nginx www-data && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      openssl-dev \
      pcre-dev \
      pkgconf \
      zlib-dev \
      musl-dev && \
    get-source build "https://nginx.org/download/nginx-$VERSION.tar.gz" && \
    echo "Configuring and building..." > /dev/stderr && \
    cd /usr/src/build && \
    ./configure \
      --prefix=/usr/local \
      --conf-path=/etc/nginx/nginx.conf \
      \
      --user=nginx \
      --group=nginx \
      --with-threads \
      --with-file-aio \
      \
      --with-http_ssl_module \
      --with-http_v2_module \
      --with-http_realip_module \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_stub_status_module \
      \
      --without-http_empty_gif_module && \
    make && \
    mkdir -p /usr/src/target && \
    echo "Installing to temporary root..." > /dev/stderr && \
    make DESTDIR=/usr/src/target install && \
    rm -rf /usr/src/build && \
    strip-build target && \
    install-build target && \
    apk-end .builddeps && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/vhosts.d

COPY nginx.conf /etc/nginx/
COPY init /init/

EXPOSE 80 443

CMD ["/init/init"]
