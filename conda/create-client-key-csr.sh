#!/bin/bash

key="$1"
csr="$2"
name="$3"

echo $key $csr $name

openssl genrsa -out ${key} 2048

openssl req -new -key ${key} -out ${csr} -subj "/C=US/ST=Utah/L=Provo/O=Company/CN=${name}"
