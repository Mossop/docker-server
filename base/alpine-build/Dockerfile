# build = { "image": "mossop/alpine-build" }
FROM mossop/alpine

ENV CFLAGS="-Os -fomit-frame-pointer"
ENV CXXFLAGS="-Os -fomit-frame-pointer"
ENV CPPFLAGS="-Os -fomit-frame-pointer"
ENV LDFLAGS="-Wl,--as-needed"

RUN mkdir -p /usr/src/installers

COPY bin/* /usr/local/bin/
COPY installers/* /usr/src/installers/
