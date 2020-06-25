# build = { "image": "mossop/dovecot" }
FROM mossop/alpine-build

ARG VERSION=2.3.10.1
ARG PIGEON_VERSION=0.5.10

RUN MAJOR=`echo ${VERSION} | sed -E -e 's/^([0-9]+\.[0-9]+)\..*/\1/'` && \
    mkusr dovecot /var/mail/vmail 2101 && \
    mkusr dovenull /dev/null 2102 && \
    /usr/src/installers/install-libpq && \
    apk-begin .builddeps \
      build-base \
      openssl-dev && \
    get-source dovecot "https://dovecot.org/releases/${MAJOR}/dovecot-${VERSION}.tar.gz" && \
    build-package dovecot build \
      --with-pgsql && \
    strip-binaries build && \
    install-build build && \
    mkdir -p /etc/dovecot && \
    conf-build "https://pigeonhole.dovecot.org/releases/${MAJOR}/dovecot-${MAJOR}-pigeonhole-${PIGEON_VERSION}.tar.gz" && \
    apk-end .builddeps

COPY init /init/
COPY dovecot.conf /etc/dovecot/

EXPOSE 24 993 995

CMD ["/init/init"]
