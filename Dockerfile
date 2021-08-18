FROM nginx:alpine

WORKDIR /

COPY ./config /
COPY ./src/nxconf.sh /

RUN chmod +x /nxconf.sh && /nxconf.sh

RUN mkdir -p /var/log/nginx /var/cache/nginx /var/run/nginx && \
    chown -R nginx:nginx /var/log/nginx /var/run/nginx /var/cache/nginx /etc/nginx && \
    sed -e 's#/var/run/nginx.pid#/var/run/nginx/nginx.pid#' -e '/user  nginx;/d'  -i /etc/nginx/nginx.conf

EXPOSE 80

USER nginx

CMD ["nginx", "-g", "daemon off;"]
