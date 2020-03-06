FROM nginx:1.12-alpine
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /data/www
COPY index.html /data/www

RUN apk update && apk add openssl

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /etc/nginx/logs

RUN mkdir -p /etc/nginx/clients
COPY sign-certificate-request.sh /etc/nginx/clients

RUN openssl genrsa -out /etc/nginx/ssl/ca.key 2048
RUN openssl req -x509 -new -nodes -key /etc/nginx/ssl/ca.key -days 365 -out /etc/nginx/ssl/ca.crt -subj "/C=BY/ST=Minsk/L=Minsk/O=FeatureMine/CN=CA Provider"

RUN openssl genrsa -out /etc/nginx/ssl/server.key 2048
RUN openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=US/ST=Utah/L=Provo/O=Company/CN=127.0.0.1"

RUN openssl x509 -req -in /etc/nginx/ssl/server.csr -CA /etc/nginx/ssl/ca.crt -CAkey /etc/nginx/ssl/ca.key -CAcreateserial -out /etc/nginx/ssl/server.crt -days 365
