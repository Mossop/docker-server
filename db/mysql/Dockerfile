FROM mysql

RUN mkdir /etc/mysql/docker.d && \
    mv /etc/mysql/conf.d/* /etc/mysql/docker.d && \
    echo "!includedir /etc/mysql/docker.d/" >> /etc/mysql/my.cnf
COPY docker.d/*.cnf /etc/mysql/docker.d/
