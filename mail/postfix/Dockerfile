FROM mossop/alpine

RUN mkusr postfix /var/mail/spool 2051 && \
    mkusr postdrop /var/mail/spool 2052 && \
    addgroup postfix mail && \
    apk-add \
      postfix \
      postfix-mysql

COPY bin/* /usr/local/bin/

EXPOSE 25 587

CMD ["/usr/local/bin/init"]
