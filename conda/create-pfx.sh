#!/bin/bash

# Create PFX format for a certificate
# Params: keyPath crtPath pfxPath

KEY="$1"
CSR="$2"
PFX="$3"

openssl pkcs12 \
        -export \
        -nodes \
        -inkey $KEY \
        -in $CSR \
        -out $PFX \
        -password pass:pwd
