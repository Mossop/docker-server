FROM alpine

ENV CFLAGS="-Os -fomit-frame-pointer"
ENV CXXFLAGS="-Os -fomit-frame-pointer"
ENV CPPFLAGS="-Os -fomit-frame-pointer"
ENV LDFLAGS="-Wl,--as-needed"

COPY bin/* /usr/local/bin/

RUN set -ex && \
    apk-begin .setup \
      tzdata && \
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    echo "America/Los_Angeles" > /etc/timezone && \
    apk-end .setup && \
    deluser postmaster && \
    deluser cyrus && \
    deluser mail && \
    deluser postgres && \
    mkusr www-data /var/www/html 2001 && \
    mkusr mail /var/spool/mail 2002 && \
    mkusr vmail /var/mail/vmail 2003
