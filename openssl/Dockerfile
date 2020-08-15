FROM nginx:1.12-alpine

RUN apk update && apk add openssl
RUN apk update && apk add bash

RUN mkdir -p /data/www/conda-bld
RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /etc/nginx/ssl/clients
RUN mkdir -p /etc/nginx/logs

COPY nginx.conf /etc/nginx/nginx.conf

COPY create-root-ca.sh /etc/nginx/ssl/
COPY create-key-and-csr.sh /etc/nginx/ssl/
COPY sign-certificate-request.sh /etc/nginx/ssl/
COPY v3.ext /etc/nginx/ssl/

WORKDIR /etc/nginx/ssl/
RUN bash create-root-ca.sh
RUN bash create-key-and-csr.sh
RUN bash sign-certificate-request.sh server.csr server.crt true

ADD conda-bld /data/www/conda-bld
