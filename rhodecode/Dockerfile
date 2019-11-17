# build = { "image": "mossop/rhodecode" }
FROM mossop/alpine-build

ARG RCCONTROL_VERSION=1.23.3
ENV VCSSERVER_VERSION=4.17.4
ENV COMMUNITY_VERSION=4.17.4

COPY bin/* /usr/local/bin/

RUN apk-add \
      sudo \
      openssh-server && \
    /usr/src/installers/install-locales && \
    /usr/src/installers/install-python2 && \
    mkdir -p /opt/rhodecode/store /rhodecode/cache /rhodecode/repos /rhodecode/.ssh /rhodecode/services/ssh && \
    mkusr rhodecode /rhodecode 2500 && \
    passwd -u rhodecode && \
    sed -E -e s@:/rhodecode:/sbin/nologin@:/rhodecode:/bin/sh@ -i /etc/passwd && \
    chown rhodecode:rhodecode /rhodecode/repos /rhodecode/.ssh /rhodecode/services && \
    download -d /rhodecode/cache -o MANIFEST https://dls.rhodecode.com/linux/MANIFEST && \
    install RhodeCodeControl-${RCCONTROL_VERSION}+x86_64-linux control && \
    install RhodeCodeVCSServer-${VCSSERVER_VERSION}+x86_64-linux vcsserver && \
    install RhodeCodeCommunity-${COMMUNITY_VERSION}+x86_64-linux community && \
    ln -s `readlink /rhodecode/cache/control` /rhodecode/profile && \
    rm -rf /usr/src/*

COPY sudoers /etc/sudoers
COPY sshd_config /etc/ssh/
COPY init /init/

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    MUSL_LOCPATH=/usr/local/share/i18n/locales/musl
WORKDIR /rhodecode

CMD ["/init/init"]
