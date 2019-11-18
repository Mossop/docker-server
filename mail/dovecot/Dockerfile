# build = { "image": "mossop/dovecot" }
FROM mossop/alpine

RUN mkusr dovecot /var/mail/vmail 2101 && \
    mkusr dovenull /dev/null 2102 && \
    apk-add \
      dovecot \
      dovecot-lmtpd \
      dovecot-pop3d \
      dovecot-mysql

COPY init /init/

EXPOSE 24 993 995

CMD ["/init/init"]
