# build = { "image": "mossop/rhodecode" }
FROM mossop/alpine-build

ENV VCSSERVER_VERSION=4.17.4
ENV COMMUNITY_VERSION=4.17.4
ARG RCCONTROL_VERSION=NzA2MjdhN2E2ODYxNzY2NzZjNDA2NTc1NjI3MTcyNzA2MjcxNzIyZTcwNjI3YQ==

COPY bin/* /usr/local/bin/

RUN /usr/src/installers/install-locales && \
    /usr/src/installers/install-python2 && \
    mkdir -p /opt/rhodecode /rhodecode && \
    mkusr rhodecode /rhodecode 2500 && \
    chown -R rhodecode:rhodecode /opt/rhodecode /rhodecode /usr/src && \
    echo "Cmnd_Alias GUNICORN = /rhodecode/services/vcsserver/profile/bin/gunicorn, /rhodecode/services/community/profile/bin/gunicorn" > /etc/sudoers && \
    echo "rhodecode ALL=(ALL) NOPASSWD: GUNICORN" >> /etc/sudoers && \
    apk-add \
      curl \
      sudo \
      aria2 \
      tar

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    MUSL_LOCPATH=/usr/local/share/i18n/locales/musl
USER rhodecode
WORKDIR /rhodecode

RUN mkdir -p /rhodecode/.rccontrol/cache /rhodecode/repos && \
    aria2c -d /rhodecode/.rccontrol/cache https://dls.rhodecode.com/linux/MANIFEST && \
    cd /usr/src && \
    curl -L -O -J https://dls-eu.rhodecode.com/dls/${RCCONTROL_VERSION}/rhodecode-control/latest-linux-ce && \
    chmod 755 /usr/src/RhodeCode-installer-* && \
    cd /rhodecode && \
    /usr/src/RhodeCode-installer-* --accept-license --create-install-directory && \
    cat /rhodecode/.rccontrol/cache/MANIFEST | \
      sed -E -e "s/.+ //" | \
      grep RhodeCodeVCSServer-${VCSSERVER_VERSION}+x86_64-linux | \
      xargs install && \
    cat /rhodecode/.rccontrol/cache/MANIFEST | \
      sed -E -e "s/.+ //" | \
      grep RhodeCodeCommunity-${COMMUNITY_VERSION}+x86_64-linux | \
      xargs install && \
    rm -rf /usr/src/*

CMD ["/usr/local/bin/init"]
