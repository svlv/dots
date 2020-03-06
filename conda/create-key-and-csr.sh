#!/bin/bash

FQDN="172.28.10.202"

openssl genrsa -out server.key 2048

openssl req -new -key server.key -out server.csr -subj "/C=US/ST=Utah/L=Provo/O=Company/CN=${FQDN}"
