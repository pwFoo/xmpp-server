#!/bin/sh

# Check if required variables are available
if [ -z "${XMPP_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_SERVER_URL must be set."
elif [ -z "${XMPP_GROUPS_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_GROUPS_URL must be set."
elif [ -z "${ADMIN_EMAIL}" ]; then
    echo "Failure starting xmpp server: The environment variable ADMIN_EMAIL must be set."
elif [ -z "${XMPP_ADMIN}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_ADMIN must be set."
elif [ -z "${SECRET}" ]; then
    echo "Failure starting xmpp server: The environment variable SECRET must be set."
elif [ -z "${TURN_HOST}" ]; then
    echo "Failure starting xmpp server: The environment variable TURN_HOST must be set."
else

    echo "Welcome to your turn-server"
    echo "Main server url: ${TURN_HOST}"
    echo "IPv4 address: ${TURN_IPV4}"
    echo "IPv6 address: ${TURN_IPV6}"

    # Replace required variables with configuration
    sed -i "s#{{SECRET}}#${SECRET}#" /etc/eturnal.yml
    sed -i "s#{{TURN_IPV4}}#${TURN_IPV4}#" /etc/eturnal.yml
    sed -i "s#{{TURN_IPV6}}#${TURN_IPV6}#" /etc/eturnal.yml

    # Prepare certificates to be in the default location where eturnal expects them
    mkdir -p /tmp/certs && mkdir -p /etc/eturnal/tls/
    if [ -f /cert/acme.json ]; then
        traefik-certs-dumper file --domain-subdir --crt-ext=.pem --key-ext=.pem --source /cert/acme.json --dest /tmp/certs --version v2
        if [ -f /tmp/certs/${TURN_HOST}/privatekey.pem ]; then
            mv /tmp/certs/${TURN_HOST}/certificate.pem /tmp/certs/${TURN_HOST}/privatekey.pem /etc/eturnal/tls/
            chown -R eturnal:eturnal /etc/eturnal
        else
            echo "ERROR: Traefik generated certificates not found for host domain"
        fi
    else
        echo "ERROR: No certificates have been provided from traefik"
    fi
fi

exec eturnalctl foreground "$@"