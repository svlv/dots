#!/bin/bash

# Generate root CA

KEY="ca.key"
CRT="ca.crt"

COUNTRY="BY"
STATE="Minsk"
LOCALITY="Minsk"
ORGANIZATION="FeatureMine"
COMMONNAME="CA Provider"

openssl genrsa \
        -out $KEY \
        2048

openssl req \
        -x509 \
        -new \
        -nodes \
        -key $KEY \
        -days 365 \
        -out $CRT \
        -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/CN=$COMMONNAME"
