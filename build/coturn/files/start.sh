#!/bin/bash
set -e

# set server url
echo "realm=$TURN_HOST" > /etc/turnserver.conf

# define authentification mechanism and static secret
echo "use-auth-secret" >> /etc/turnserver.conf
echo "static-auth-secret=$SECRET" >> /etc/turnserver.conf

# your external IP, needed for some connections
echo "external-ip=$TURN_EXTERNAL_IP" >> /etc/turnserver.conf
echo "listening-ip=$TURN_EXTERNAL_IP" >> /etc/turnserver.conf

# Prepare certificates to be in the default location where coturn expects them
mkdir -p /tmp/certs && mkdir -p /etc/coturn/certs
if [ -f /cert/acme.json ]; then
    traefik-certs-dumper file --source /cert/acme.json --dest /tmp/certs --version v2
    mv /tmp/certs/certs/${TURN_HOST}.crt /tmp/certs/private/${TURN_HOST}.key /etc/coturn/certs/
fi

# paths to conntecion certificates for encryption
echo "cert=/etc/prosody/certs/$TURN_HOST.key" #cert.pem
echo "pkey=/etc/prosody/certs/$TURN_HOST.crt" #privkey.pem

# main turn server ports
echo "listening-port=3478" >> /etc/turnserver.conf
echo "tls-listening-port=5349" >> /etc/turnserver.conf

# ports that clients can connect to
echo "min-port=49152" >> /etc/turnserver.conf
echo "max-port=65535" >> /etc/turnserver.conf

# handle server fingerprinting
echo "fingerprint" >> /etc/turnserver.conf
# send output to stdout for docker setup
echo "log-file stdout" >> /etc/turnserver.conf
# disable command-line access 
echo "no-cli" >> /etc/turnserver.conf

exec /usr/bin/turnserver "$@"
