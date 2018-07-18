#!/bin/sh

# Check if required variables are available
if [ -z "${XMPP_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_SERVER_URL must be set."
elif [ -z "${XMPP_GROUPS_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_GROUPS_URL must be set."
elif [ -z "${ADMIN_EMAIL}" ]; then
    echo "Failure starting xmpp server: The environment variable ADMIN_EMAIL must be set."
elif [ -z "${ADMIN_XMPP}" ]; then
    echo "Failure starting xmpp server: The environment variable ADMIN_XMPP must be set."
elif [ -z "${SECRET}" ]; then
    echo "Failure starting xmpp server: The environment variable SECRET must be set."
else

    # Prepare certificates to be in the default location where prosody expects them
    if [ -f /cert/acme.json ]; then
        mkdir -p /tmp/certs && mkdir -p /etc/prosody/certs
        /dumpcerts.sh /cert/acme.json /tmp/certs
        mv /tmp/certs/certs/${XMPP_SERVER_URL}.crt /tmp/certs/private/${XMPP_SERVER_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_GROUPS_URL}.crt /tmp/certs/private/${XMPP_GROUPS_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_HOST_URL}.crt /tmp/certs/private/${XMPP_HOST_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_ANOTHER_URL}.crt /tmp/certs/private/${XMPP_ANOTHER_URL}.key /etc/prosody/certs/

        chown -R prosody:prosody /etc/prosody/certs
    fi

    # Eventually add another virtual host
    if [ -n "${XMPP_HOST_URL}" ]; then
        echo 'VirtualHost ("'${XMPP_HOST_URL}'")' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        http_host = "'${XMPP_HOST_URL}'"' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        http_external_url = "https://'${XMPP_HOST_URL}'"' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        disco_items = {' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '                { "{{XMPP_GROUPS_URL}}", "A group chat (muc) service" };' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        }' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '' >> /etc/prosody/virtual-hosts.cfg.lua
    fi

    # Eventually add another virtual host
    if [ -n "${XMPP_ANOTHER_URL}" ]; then
        echo '' >> /etc/prosody/virtual-hosts.cfg.lua
        echo 'VirtualHost ("'${XMPP_ANOTHER_URL}'")' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        http_host = "'${XMPP_SERVER_URL}'"' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        http_external_url = "https://'${XMPP_SERVER_URL}'"' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        disco_items = {' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '                { "{{XMPP_GROUPS_URL}}", "A group chat (muc) service" };' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        }' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '' >> /etc/prosody/virtual-hosts.cfg.lua
    fi

    # Replace variables in configuration
    sed -i "s#{{ADMIN_EMAIL}}#${ADMIN_EMAIL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{ADMIN_XMPP}}#${ADMIN_XMPP}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/components.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/components.cfg.lua
    sed -i "s#{{SECRET}}#${SECRET}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/virtual-hosts.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/virtual-hosts.cfg.lua

    chown -R prosody:prosody /var/lib/prosody/data

    # Go jabber go
    prosodyctl start
fi


