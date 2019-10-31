# build = { "image": "mossop/mysql" }
FROM mysql:8.0.18

RUN mv /etc/mysql/conf.d /etc/mysql/defaults.d && \
    mkdir /etc/mysql/conf.d && \
    echo "!includedir /etc/mysql/defaults.d/" >> /etc/mysql/my.cnf
COPY defaults.d/*.cnf /etc/mysql/defaults.d/
