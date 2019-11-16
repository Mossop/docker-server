# build = { "image": "mossop/alpine", "type": "squashed" }
FROM alpine:3.10.3

COPY bin/* /usr/local/bin/

RUN set -ex && \
    apk upgrade --no-cache && \
    apk add runit && \
    mkdir -p /init/services /etc/runit && \
    ln -s /init/startup /etc/runit/1 && \
    ln -s /init/run /etc/runit/2 && \
    ln -s /init/shutdown /etc/runit/3 && \
#
#   Configure timezone.
#
    apk-begin .setup \
      tzdata && \
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    echo "America/Los_Angeles" > /etc/timezone && \
    apk-end .setup && \
#
#   Clear out existing users and groups.
#
    deluser postmaster 2> /dev/null && \
    deluser cyrus 2> /dev/null && \
    deluser mail 2> /dev/null && \
    deluser postgres 2> /dev/null && \
#
#   Create shared users.
#
    mkusr www-data /var/www/html 2001 && \
    mkusr mail /var/spool/mail 2002 && \
    mkusr vmail /var/mail/vmail 2003

COPY init/* /init/

CMD ["/bin/sh"]
