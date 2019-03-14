FROM alpine
RUN apk add --no-cache postfix && \
    chown postfix:postfix /var/lib/postfix

CMD ["/usr/sbin/postfix", "start-fg"]
