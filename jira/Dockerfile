# build = { "image": "mossop/jira" }
FROM mossop/alpine

ARG VERSION=8.5.1

COPY bin /bin/

RUN mkusr jira /jira 2901 && \
    apk-begin .builddeps \
      curl && \
    mkdir -p /usr/src && \
    cd /usr/src && \
    curl -L -o jira.tar.gz "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${VERSION}.tar.gz" && \
    tar -xf jira.tar.gz && \
    mkdir -p /opt && \
    mv /usr/src/atlassian-* /opt/jira && \
    apk-end .builddeps && \
    apk-add \
      openjdk8-jre \
      su-exec \
      bash && \
    mkdir -p /jira/home /jira/base/logs /jira/base/temp /jira/base/conf && \
    chown -R jira:jira /jira && \
    change-ini-value /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties jira.home /jira/home

ENV JIRA_HOME=/jira/home \
    JIRA_USER=jira \
    CATALINA_HOME=/opt/jira \
    CATALINA_BASE=/jira/base

COPY init /init/

CMD ["/init/init"]
