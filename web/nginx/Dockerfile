FROM mossop/alpine

RUN mkusr nginx /var/www 2201 && \
    addgroup nginx www-data && \
    apk-add \
      nginx && \
    rm /etc/nginx/conf.d/default.conf && \
    mkdir /etc/nginx/vhosts.d && \
    mkdir /run/nginx

COPY nginx.conf /etc/nginx/

COPY bin/* /usr/local/bin/

EXPOSE 80 443

CMD ["/usr/local/bin/init"]
