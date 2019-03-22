# build = { "image": "mossop/openvpn" }
FROM mossop/alpine

RUN apk-add openvpn && \
    mkdir -p /etc/openvpn && \
    mkdir -p /var/openvpn/pid

COPY bin/* /usr/local/bin/

EXPOSE 1194

CMD ["/usr/local/bin/init"]
