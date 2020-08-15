#!/bin/bash

FQDN="$1"

cat \
  "certs/${FQDN}/server.key" \
  "certs/${FQDN}/server.csr" \
  > "certs/${FQDN}/server.pem"

cat \
  "certs/ca.crt" \
  > "certs/${FQDN}/chain.csr"

cat \
  "certs/${FQDN}/server.csr" \
  "certs/ca.crt" \
  > "certs/${FQDN}/fullchain.csr"
