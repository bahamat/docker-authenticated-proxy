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
RUN apk add --no-cache squid apache2-utils
RUN mkdir -p /var/cache/squid /var/log/squid \
    && chown -R squid:squid /var/cache/squid /var/log/squid

COPY squid.conf /etc/squid.conf
COPY htpasswd.example /etc/htpasswd

ENTRYPOINT ["squid","-N","-f","/etc/squid.conf"]
