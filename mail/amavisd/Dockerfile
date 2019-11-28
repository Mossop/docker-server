# build = { "image": "mossop/amavisd" }
FROM mossop/alpine-build

ARG AMAVIS_VERSION=2.11.1
ARG RAZOR_VERSION=2.84
ARG CPAN_ARGS=-n

COPY init /init/

RUN apk-add \
      perl \
      perl-utils \
      file \
      gzip \
      bzip2 \
      lha \
      p7zip \
      cpio \
      cabextract \
      db \
      gnupg \
      re2c \
      openssl \
      zip \
      libidn \
      zlib \
      unrar \
      unarj \
      lrzip \
      lz4 \
      altermime \
      rpm2cpio \
      binutils && \
    apk-begin .builddeps \
      build-base \
      wget \
      perl-dev \
      openssl-dev \
      db-dev \
      zlib-dev \
      perl-doc \
      libidn-dev \
      bzip2-dev && \
    curl -L https://cpanmin.us | perl - App::cpanminus && \
    cpanm ${CPAN_ARGS} Archive::Zip && \
    cpanm ${CPAN_ARGS} Compress::Zlib && \
    cpanm ${CPAN_ARGS} Compress::Raw::Zlib && \
    cpanm ${CPAN_ARGS} MIME::Base64 && \
    cpanm ${CPAN_ARGS} MIME::Parser && \
    cpanm ${CPAN_ARGS} Mail::Internet && \
    cpanm ${CPAN_ARGS} Net::Server && \
    cpanm ${CPAN_ARGS} Digest::MD5 && \
    cpanm ${CPAN_ARGS} Time::HiRes && \
    cpanm ${CPAN_ARGS} Unix::Syslog && \
    cpanm ${CPAN_ARGS} Mail::DKIM && \
    cpanm ${CPAN_ARGS} HTML::Parser && \
    cpanm ${CPAN_ARGS} Net::DNS && \
    cpanm ${CPAN_ARGS} Digest::SHA1 && \
    cpanm ${CPAN_ARGS} DB_File && \
    cpanm ${CPAN_ARGS} Mail::SPF && \
    cpanm ${CPAN_ARGS} Geo::IP && \
    cpanm ${CPAN_ARGS} Net::CIDR::Lite && \
    cpanm ${CPAN_ARGS} IO::Socket::IP && \
    cpanm ${CPAN_ARGS} IO::Socket::SSL && \
    cpanm ${CPAN_ARGS} LWP::UserAgent && \
    cpanm ${CPAN_ARGS} HTTP::Date && \
    cpanm ${CPAN_ARGS} Encode::Detect::Detector && \
    cpanm ${CPAN_ARGS} Net::Patricia && \
    cpanm ${CPAN_ARGS} Net::DNS::Nameserver && \
    cpanm ${CPAN_ARGS} BSD::Resource && \
    cpanm ${CPAN_ARGS} Getopt::Long && \
    cpanm ${CPAN_ARGS} File::Copy && \
    cpanm ${CPAN_ARGS} URI::Escape && \
    cpanm ${CPAN_ARGS} IO::Stringy && \
    cpanm ${CPAN_ARGS} Net::LibIDN && \
    cpanm ${CPAN_ARGS} Convert::BinHex && \
    cpanm ${CPAN_ARGS} BerkeleyDB && \
    cpanm ${CPAN_ARGS} Mail::SpamAssassin && \
    rm -rf /root/.cpanm && \
    get-source razor-agent "https://downloads.sourceforge.net/project/razor/razor-agents/${RAZOR_VERSION}/razor-agents-${RAZOR_VERSION}.tar.bz2" && \
    cd /usr/src/razor-agent && \
    perl Makefile.PL && \
    make && \
    make test && \
    make install && \
    apk-end .builddeps && \
    get-source amavisd "https://www.ijs.si/software/amavisd/amavisd-new-${AMAVIS_VERSION}.tar.bz2" && \
    mkusr amavis /amavisd 2801 && \
    cp /usr/src/amavisd/amavisd /usr/local/bin && \
    mv /etc/mail/spamassassin/local.cf /init/conf/spamassassin.cf

COPY amavisd.conf /etc/amavisd.conf

EXPOSE 10024

CMD ["/init/init"]
