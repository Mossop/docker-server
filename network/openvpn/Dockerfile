# build = { "image": "mossop/openvpn" }
FROM mossop/alpine

RUN apk-add openvpn && \
    mkdir -p /etc/openvpn && \
    mkdir -p /var/openvpn/pid

COPY init /init/

EXPOSE 1194

CMD ["/init/init"]
