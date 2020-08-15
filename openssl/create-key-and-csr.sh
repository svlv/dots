#!/bin/bash

# Generate private key and certificate signing request
# Params: keyPath csrPath commonName

KEY="$1"
CSR="$2"

COUNTRY="BY"
STATE="Minsk"
LOCALITY="Minsk"
ORGANIZATION="FeatureMine"
COMMONNAME="$3"

if [ -z "$KEY" ]; then
    KEY="server.key"
fi

if [ -z "$CSR" ]; then
    CSR="server.csr"
fi

if [ -z "$COMMONNAME" ]; then
    COMMONNAME="127.0.0.1"
fi

openssl genrsa \
        -out $KEY \
        2048

openssl req \
        -new \
        -key $KEY \
        -out $CSR \
        -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/CN=$COMMONNAME"
