FROM alpine:latest

LABEL org.opencontainers.image.authors="Brie <brie@example.com>"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Authenticated Proxy"
LABEL org.opencontainers.image.description="Instant Proxy with required authentication"
LABEL org.opencontainers.image.source="https://github.com/bahamat/docker-authenticated-proxy"
LABEL copyright="Copyright (c) 2026 Brie Bennett https://github.com/bahamat"
LABEL maintainer="Brie Bennett https://github.com/bahamat"

ARG VCS_REF
ARG BUILD_DATE

EXPOSE 80
RUN mkdir -p /run/apache2
RUN apk add --update-cache apache2 apache2-ctl apache2-proxy apache2-utils
ADD proxy.conf /etc/apache2/conf.d/proxy.conf
ADD htpasswd.example /etc/apache2/htpasswd
ENTRYPOINT ["/usr/sbin/apachectl","-D","FOREGROUND"]
