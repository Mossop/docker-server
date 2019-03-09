FROM nginx:alpine

RUN rm /var/log/nginx/access.log && rm /var/log/nginx/error.log
COPY vhosts.conf /etc/nginx/conf.d/vhosts.conf
COPY docker.conf /etc/nginx/conf.d/docker.conf

EXPOSE 80 443
