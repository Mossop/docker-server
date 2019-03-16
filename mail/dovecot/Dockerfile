FROM alpine

RUN apk add --no-cache \
      dovecot \
      dovecot-lmtpd \
      dovecot-pop3d \
      dovecot-mysql

COPY bin/* /usr/local/bin/

EXPOSE 24 993 995

CMD ["/usr/local/bin/run.sh"]
