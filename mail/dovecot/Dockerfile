FROM alpine
RUN apk add --no-cache dovecot && \
    mv /etc/dovecot/conf.d /etc/dovecot/defaults.d && \
    mkdir /etc/dovecot/conf.d && \
    sed -i -e "s@include conf\\.d/@include defaults.d/@" /etc/dovecot/dovecot.conf && \
    echo "!include_try conf.d/*.conf" >> /etc/dovecot/dovecot.conf

CMD ["dovecot", "-F"]
