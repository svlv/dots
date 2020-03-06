#!/bin/bash

in="$1"
out="$2"

ca_crt="/etc/nginx/ssl/ca.crt"
ca_key="/etc/nginx/ssl/ca.key"

openssl x509 -req -in $in -CA $ca_crt -CAkey $ca_key -CAcreateserial -out $out -days 365
