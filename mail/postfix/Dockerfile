FROM mossop/alpine

ARG VERSION=3.4.4

RUN mkusr postfix /var/mail/spool 2051 && \
    mkusr postdrop /var/mail/spool 2052 && \
    addgroup postfix mail && \
    apk-begin .builddeps \
      coreutils \
      make \
      gcc \
      linux-headers \
      musl-dev \
      m4 \
      libnsl-dev \
      mariadb-connector-c-dev \
      db-dev \
      openssl-dev && \
    get-source postfix "https://archive.mgm51.com/mirrors/postfix-source/official/postfix-$VERSION.tar.gz" && \
    cd /usr/src/postfix && \
    ARGS="-DHAS_SHL_LOAD" && \
    AUXLIBS="$LDFLAGS" && \
    ARGS="$ARGS -DUSE_TLS" && \
    AUXLIBS="$AUXLIBS -lssl -lcrypto" && \
    ARGS="$ARGS -DUSE_SASL_AUTH -DDEF_SASL_SERVER=dovecot" && \
    ARGS="$ARGS -DHAS_MYSQL $(mysql_config --include)" && \
    make makefiles \
      OPT="$CFLAGS" \
      CCARGS="$ARGS" \
      AUXLIBS="$AUXLIBS" \
      AUXLIBS_MYSQL="$(mysql_config --libs)" \
      config_directory=/etc/postfix \
      meta_directory=/etc/postfix \
      daemon_directory=/usr/libexec/postfix \
      shlib_directory=/usr/lib/postfix \
      dynamicmaps=yes \
      shared=yes \
      makefiles && \
    make OPT="$CFLAGS" && \
    mkdir -p /usr/src/target && \
    make non-interactive-package \
      install_root="/usr/src/target" \
      readme_directory=/usr/share/doc/postfix/readme \
      manpage_directory=/usr/share/man && \
    apk-end .builddeps && \
    cd /usr/src && rm -rf /usr/src/postfix && \
    cat /usr/src/target/etc/postfix/postfix-files | \
      grep -v "html_directory" | \
      grep -v "readme_directory" | \
      grep -v "sample_directory" | \
      grep -v "manpage_directory" \
      >postfix-files && \
    mv -f postfix-files /usr/src/target/etc/postfix/postfix-files && \
    strip-build target && \
    install-build target && \
    chown postfix /var/spool/postfix/* /var/lib/postfix && \
    chown root:postfix /var/spool/postfix/pid && \
    chgrp postdrop /var/spool/postfix/maildrop /var/spool/postfix/public && \
    postfix set-permissions

COPY bin/* /usr/local/bin/

EXPOSE 25 587

CMD ["/usr/local/bin/init"]
