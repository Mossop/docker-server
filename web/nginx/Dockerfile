FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf && \
    mv /etc/nginx/conf.d /etc/nginx/docker.d && \
    mkdir /etc/nginx/conf.d && \
    mkdir /etc/nginx/vhosts.d && \
    sed -i -e s@/etc/nginx/conf\.d@/etc/nginx/docker\.d@ /etc/nginx/nginx.conf

COPY docker.d/*.conf /etc/nginx/docker.d/

EXPOSE 80 443
