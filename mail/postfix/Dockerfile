# build = { "image": "mossop/postfix" }
FROM mossop/alpine

RUN mkusr postfix /var/mail/spool 2051 && \
    mkusr postdrop /var/mail/spool 2052 && \
    addgroup postfix mail && \
    apk-add \
      postfix \
      postfix-pgsql && \
    touch /etc/aliases && \
    postalias /etc/aliases

COPY init /init/

EXPOSE 25 587

CMD ["/init/init"]
