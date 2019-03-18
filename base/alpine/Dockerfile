FROM alpine

COPY bin/* /usr/local/bin/

RUN set -ex && \
    apk-begin .setup \
      tzdata && \
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    echo "America/Los_Angeles" > /etc/timezone && \
    apk-end .setup
