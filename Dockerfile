FROM nginx:alpine

WORKDIR /

COPY ./config /
COPY ./src/nxconf.sh /

RUN chmod +x /nxconf.sh && /nxconf.sh

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
