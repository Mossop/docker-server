# build = { "image": "mossop/postsrsd" }
FROM mossop/alpine-build

ARG VERSION=1.6

RUN apk-begin .builddeps \
      coreutils \
      make \
      cmake \
      gcc \
      g++ \
      pkgconf \
      musl-dev && \
    get-source postsrsd "https://github.com/roehling/postsrsd/archive/${VERSION}.tar.gz" && \
    mkdir /usr/src/postsrsd/build && \
    cd /usr/src/postsrsd/build && \
    cmake \
      -DGENERATE_SRS_SECRET=OFF \
      -DINIT_FLAVOR=none \
      -DSYSCONF_DIR=/etc/postsrsd \
      -DCONFIG_DIR=/etc/postsrsd \
      ../ && \
    make && \
    mkdir -p /usr/src/target && \
    echo "Installing to temporary root" > /dev/stderr && \
    make DESTDIR=/usr/src/target install && \
    strip-build target && \
    install-build target && \
    rm /etc/postsrsd/postsrsd && \
    apk-end .builddeps

COPY bin/* /usr/local/bin/

ENV SRS_SEPARATOR==
ENV SRS_SECRET=/etc/postsrsd/postsrsd.secret
ENV SRS_HASHLENGTH=4
ENV SRS_HASHMIN=4
ENV SRS_FORWARD_PORT=10001
ENV SRS_REVERSE_PORT=10002
ENV RUN_AS=nobody
ENV SRS_LISTEN_ADDR=0.0.0.0
ENV CHROOT=/usr/local/lib/postsrsd

CMD ["/usr/local/bin/init"]
