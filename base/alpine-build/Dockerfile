# build = { "image": "mossop/alpine-build" }
FROM mossop/alpine

ENV CFLAGS="-Os -fomit-frame-pointer"
ENV CXXFLAGS="-Os -fomit-frame-pointer"
ENV CPPFLAGS="-Os -fomit-frame-pointer"
ENV LDFLAGS="-Wl,--as-needed"

COPY bin/* /usr/local/bin/
