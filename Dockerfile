FROM debian:jessie
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install python wget -y && \
    echo "deb http://nginx.org/packages/debian/ jessie nginx"  >> /etc/apt/sources.list && \
    echo "deb-src http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list && \
    wget -q -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get update && apt-get install nginx=1.14.0 -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY scripts /etc/nginx/scripts
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
EXPOSE 443
VOLUME ["/var/log/nginx", "/var/nginx/conf", "/var/nginx/security", "/var/nginx/site", "/etc/nginx/sites-enabled", "/etc/nginx/main-scope-conf"]
ENTRYPOINT ["/etc/nginx/scripts/run-nginx"]
