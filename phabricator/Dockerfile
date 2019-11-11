# build = { "image": "mossop/phabricator" }
FROM mossop/php-fpm

ARG GITVERSION=2.24.0
ARG PYTHONVERSION=2.7.17

COPY bin/* /usr/local/bin/

RUN apk-add \
      openssh-client \
      ncurses \
      procps && \
    apk-begin .builddeps \
      autoconf \
      curl \
      coreutils \
      make \
      gcc \
      linux-headers \
      pkgconf \
      musl-dev \
      zlib-dev \
      curl-dev \
      sqlite-dev \
      db-dev \
      ncurses-dev \
      openssl-dev \
      tcl-dev \
      tk-dev \
      bzip2-dev \
      gdbm-dev \
      readline-dev && \
    set -e && \
    mkdir -p /usr/src/git /usr/src/build && \
    curl -L -s "https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GITVERSION}.tar.gz" | \
      tar -xzf - -C /usr/src/git --strip-components=1 && \
    cd /usr/src/git && \
    make configure && \
    NO_PERL=YesPlease \
      NO_OPENSSL=YesPlease \
      NO_EXPAT=YesPlease \
      NO_TCLTK=YesPlease \
      NO_GETTEXT=YesPlease \
      ./configure --prefix=/usr \
    make all && \
    make DESTDIR=/usr/src/build install && \
    strip-build build && \
    install-build build && \
    rm -rf /usr/src/git && \
    get-source python https://www.python.org/ftp/python/${PYTHONVERSION}/Python-${PYTHONVERSION}.tar.xz && \
    build-package python build \
      --prefix=/usr && \
    cp -R /usr/src/build/usr/include/python2.7 /usr/include/python2.7 && \
    strip-build build && \
    install-build build && \
    rm -rf /usr/src/python && \
    cd /usr/src && \
    curl -L -s https://bootstrap.pypa.io/get-pip.py | python - && \
    pip install mercurial hg-evolve Pygments && \
    pecl install apcu && \
    echo "extension=apcu.so" >>/etc/php/php.ini && \
    apk-end .builddeps && \
    mkdir -p /etc/ssh/keys /repositories /storage /phabricator && \
    mkusr phab-daemon /repositories 2410 && \
    addgroup -S --gid 2420 phabricator && \
    adduser -S -D -H --uid 2420 -s /bin/sh -g phabricator -h /repositories -G phabricator phabricator && \
    sed -i 's/phabricator:!:/phabricator:NP:/' /etc/shadow && \
    chown -R php:php . /storage && \
    chown -R phab-daemon:phab-daemon /repositories && \
    apk-add \
      openssh-server \
      sudo

COPY sudoers /etc/sudoers.d/phabricator
COPY sshd_config /etc/ssh/

RUN cd /phabricator && \
    git clone -b stable --progress https://github.com/phacility/libphutil.git && \
    git clone -b stable --progress https://github.com/phacility/arcanist.git && \
    git clone -b stable --progress https://github.com/phacility/phabricator.git

ENV PATH="/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/phabricator/phabricator/bin"

WORKDIR /phabricator/phabricator

CMD ["/usr/local/bin/init"]
