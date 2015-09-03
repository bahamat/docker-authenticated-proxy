FROM debian:latest
MAINTAINER Brian Bennett brian.bennett@joyent.com
EXPOSE 80
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_LOG_DIR=/var/log/apache2
RUN apt-get update && apt-get -y install apache2 apache2-utils && apt-get clean
RUN ["a2enmod","proxy"]
RUN ["a2enmod","proxy_connect"]
RUN ["a2enmod","proxy_ftp"]
RUN ["a2enmod","proxy_http"]
ADD proxy.conf /etc/apache2/mods-enabled/proxy.conf
ADD htpasswd.example /etc/apache2/htpasswd
ENTRYPOINT ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
