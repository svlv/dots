#!/bin/bash

openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -days 365 -out ca.crt -subj "/C=BY/ST=Minsk/L=Minsk/O=FeatureMine/CN=127.0.0.1"
