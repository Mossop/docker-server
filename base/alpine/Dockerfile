# build = { "image": "mossop/alpine", "type": "squashed" }
FROM alpine

COPY bin/* /usr/local/bin/

RUN set -ex && \
    apk upgrade --no-cache && \
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

CMD ["/bin/sh"]
