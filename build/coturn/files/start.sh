#!/bin/bash
set -e

# set server url
echo "realm=$TURN_HOST" > /etc/turnserver.conf

# define authentification mechanism and static secret
echo "use-auth-secret" >> /etc/turnserver.conf
echo "static-auth-secret=$SECRET" >> /etc/turnserver.conf

# your external IP, needed for some connections
echo "external-ip=$TURN_EXTERNAL_IP" >> /etc/turnserver.conf

# Prepare certificates to be in the default location where coturn expects them
mkdir -p /tmp/certs && mkdir -p /etc/coturn/certs
if [ -f /cert/acme.json ]; then
    traefik-certs-dumper file --domain-subdir --crt-ext=.pem --key-ext=.pem --source /cert/acme.json --dest /tmp/certs --version v2
    if [ -f /tmp/certs/${TURN_HOST}/privatekey.pem ]; then
        mv /tmp/certs/${TURN_HOST}/certificate.pem /tmp/certs/${TURN_HOST}/privatekey.pem /etc/coturn/certs/
        # paths to conntecion certificates for encryption
        echo "cert=/etc/coturn/certs/certificate.pem"
        echo "pkey=/etc/coturn/certs/privatekey.pem"
    else
        echo "ERROR: Traefik generated letsencrypt certificates not found!"
    fi
fi


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
