FROM alpine:latest
MAINTAINER Brian Bennett brian.bennett@joyent.com
EXPOSE 80
RUN mkdir -p /run/apache2
RUN apk add --update-cache apache2 apache2-proxy apache2-utils
ADD proxy.conf /etc/apache2/conf.d/proxy.conf
ADD htpasswd.example /etc/apache2/htpasswd
ENTRYPOINT ["/usr/sbin/apachectl","-D","FOREGROUND"]
