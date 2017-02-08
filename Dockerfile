FROM debian:jessie
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install python wget -y && \
    echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx"  >> /etc/apt/sources.list && \
    echo "deb-src http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list && \
    wget -q -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get update && apt-get install nginx -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    sed -i 's#include /etc/nginx/conf.d/\*.conf#include /etc/nginx/sites-enabled/*#' /etc/nginx/nginx.conf && \
    mkdir /etc/nginx/main-scope-conf && \
    echo "include /etc/nginx/main-scope-conf/*;" >> /etc/nginx/nginx.conf
COPY scripts /etc/nginx/scripts
EXPOSE 80
EXPOSE 443
VOLUME ["/var/log/nginx", "/var/nginx/conf", "/var/nginx/security", "/var/nginx/site", "/etc/nginx/sites-enabled"]
ENTRYPOINT ["/etc/nginx/scripts/run-nginx"]
