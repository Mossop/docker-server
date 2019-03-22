# build = { "image": "mossop/php-fpm" }
FROM php:fpm-alpine

ENV EXTENSIONS="mysqli bz2 zip"

RUN apk add --no-cache \
      libbz2 \
      libzip && \
    apk add --no-cache --virtual .build-deps \
      bzip2-dev \
      zlib-dev \
      libzip-dev && \
    docker-php-ext-install $EXTENSIONS && \
    docker-php-ext-enable $EXTENSIONS && \
    apk del --no-network .build-deps
