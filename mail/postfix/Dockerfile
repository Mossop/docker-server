FROM alpine
RUN apk add --no-cache \
      postfix \
      postfix-mysql && \
    chown postfix:postfix /var/lib/postfix && \
    postalias /etc/postfix/aliases

COPY bin/* /usr/local/bin/

CMD ["/usr/local/bin/run.sh"]
