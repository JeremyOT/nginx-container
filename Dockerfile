FROM debian:wheezy
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install python nginx -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY scripts /etc/nginx/scripts
EXPOSE 80
EXPOSE 443
VOLUME ["/var/log/nginx", "/var/nginx/conf", "/var/nginx/security", "/var/nginx/site"]
ENTRYPOINT ["/etc/nginx/scripts/run-nginx"]
