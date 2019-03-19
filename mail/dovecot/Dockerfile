FROM mossop/alpine

RUN mkusr dovecot /var/mail/vmail && \
    mkusr dovenull /dev/null && \
    addgroup dovecot vmail && \
    apk-begin .builddeps \
      make \
      gcc \
      libtool \
      linux-headers \
      musl-dev \
      bzip2-dev \
      openssl-dev \
      zlib-dev \
      mariadb-connector-c-dev && \
    get-source dovecot "https://www.dovecot.org/releases/2.3/dovecot-2.3.5.tar.gz" && \
    build-package dovecot target \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --with-rundir=/run/dovecot \
      --with-sql \
      --with-mysql && \
    apk-end .builddeps && \
    cp -R /usr/src/target/usr/share/doc/dovecot/example-config /etc/dovecot && \
    strip-build target && \
    install-build target

COPY bin/* /usr/local/bin/

EXPOSE 24 993 995

CMD ["/usr/local/bin/init"]
