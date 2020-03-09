#!/bin/bash

# Get subject info from certificate

CRT="$1"

openssl x509 \
        -noout \
        -subject \
        -in $CRT

