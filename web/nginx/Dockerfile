# build = { "image": "mossop/nginx" }
FROM mossop/alpine-build

ARG VERSION=1.17.5

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
    conf-build "https://nginx.org/download/nginx-$VERSION.tar.gz" \
      --prefix=/usr/local/nginx \
      --sbin-path=/usr/sbin/nginx \
      --modules-path=/usr/lib/nginx/modules \
      --conf-path=/etc/nginx/nginx.conf \
      --pid-path=/run/nginx/nginx.pid \
      --lock-path=/run/nginx/nginx.lock \
      --error-log-path=/var/log/nginx/error.log \
      --http-log-path=/var/log/nginx/access.log \
      --http-client-body-temp-path=/var/tmp/nginx/client_body \
      --http-proxy-temp-path=/var/tmp/nginx/proxy \
      --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
      --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
      --http-scgi-temp-path=/var/tmp/nginx/scgi \
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
    apk-end .builddeps && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/vhosts.d && \
    mkdir -p /run/nginx && \
    mkdir -p /var/tmp/nginx && \
    mkdir -p /var/log/nginx && \
    rm -rf /usr/local/nginx

COPY nginx.conf /etc/nginx/
COPY init /init/

EXPOSE 80 443

CMD ["/init/init"]
