FROM debian:wheezy
MAINTAINER jeremyot@gmail.com

RUN echo "deb http://nginx.org/packages/mainline/debian/ codename nginx\ndeb-src http://nginx.org/packages/mainline/ debian/ codename nginx" > /etc/apt/source.list && \
    apt-get update && apt-get install python nginx -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && rm /etc/nginx/sites-enabled/default
COPY scripts /etc/nginx/scripts
EXPOSE 80
EXPOSE 443
VOLUME ["/var/log/nginx", "/var/nginx/conf", "/var/nginx/security", "/var/nginx/site", "/etc/nginx/sites-enabled"]
ENTRYPOINT ["/etc/nginx/scripts/run-nginx"]
