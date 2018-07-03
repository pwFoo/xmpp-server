#!/bin/sh

# Check if required variables are available
if [ -z "${XMPP_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_SERVER_URL must be set."
elif [ -z "${XMPP_GROUPS_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_GROUPS_URL must be set."
elif [ -z "${XMPP_ADMIN}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_ADMIN must be set."
else

    # Prepare certificates to be in the default location where prosody expects them
    if [ -f /cert/acme.json ]; then
        mkdir -p /tmp/certs && mkdir -p /etc/prosody/certs
        /dumpcerts.sh /cert/acme.json /tmp/certs
        mv /tmp/certs/certs/${XMPP_SERVER_URL}.crt /tmp/certs/private/${XMPP_SERVER_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_GROUPS_URL}.crt /tmp/certs/private/${XMPP_GROUPS_URL}.key /etc/prosody/certs/
        chown -R prosody:prosody /etc/prosody/certs
    fi

    if [ -n "${XMPP_HOST_URL}" ]; then
        echo 'VirtualHost ("'${XMPP_HOST_URL}'")' >> /etc/prosody/standard-host.cfg.lua
        echo '        http_host = "'${XMPP_HOST_URL}'"' >> /etc/prosody/standard-host.cfg.lua
        echo '        http_external_url = "https://'${XMPP_HOST_URL}'"' >> /etc/prosody/standard-host.cfg.lua
        echo ''
    fi

    # Replace variables in configuration
    sed -i "s#{{XMPP_ADMIN}}#${XMPP_ADMIN}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/standard-host.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/standard-host.cfg.lua

    chown -R prosody:prosody /var/lib/prosody/data

    # Go jabber go
    prosodyctl start
fi


