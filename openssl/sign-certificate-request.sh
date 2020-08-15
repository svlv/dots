#!/bin/bash

# Sign certificate request
# Params: csrPath crtPath v3[true]

CSR="$1"
CRT="$2"

CAKEY="ca.key"
CACRT="ca.crt"
CASRL="ca.srl"
EXT="v3.ext"

if [ -f "$CASRL" ]; then
    SERIAL="-CAserial $CASRL"
else
    SERIAL="-CAcreateserial"
fi

V3=""
if [ "$3" = "true" ]; then
    V3="-extfile $EXT"
    echo "Use v3 extention"
fi

openssl x509 \
        -req \
        -in $CSR \
        -CA $CACRT \
        -CAkey $CAKEY \
        $SERIAL \
        -out $CRT \
        -days 365 \
        $V3
