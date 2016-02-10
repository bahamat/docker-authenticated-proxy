FROM alpine:latest
MAINTAINER Brian Bennett brian.bennett@joyent.com
EXPOSE 80
RUN apk update && apk add apache2 apache2-proxy apache2-utils
RUN mkdir -p /run/apache2
ADD proxy.conf /etc/apache2/conf.d/proxy.conf
ADD htpasswd.example /etc/apache2/htpasswd
ENTRYPOINT ["/usr/sbin/apachectl","-D","FOREGROUND"]
