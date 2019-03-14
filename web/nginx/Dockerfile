FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf && \
    mv /etc/nginx/conf.d /etc/nginx/defaults.d && \
    mkdir /etc/nginx/conf.d && \
    mkdir /etc/nginx/vhosts.d && \
    sed -i -e s@/etc/nginx/conf\.d@/etc/nginx/defaults\.d@ /etc/nginx/nginx.conf

COPY defaults.d/*.conf /etc/nginx/defaults.d/

EXPOSE 80 443
