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

    echo "Welcome to your xmpp-server"
    echo "Main server url: ${XMPP_SERVER_URL}"
    echo "HTTP upload endpoint url: ${XMPP_SERVER_URL}/_xmpp/upload"
    echo "Multi user chat (MUC) url: ${XMPP_GROUPS_URL}"
    
    # Replace required variables with configuration
    sed -i "s#{{ADMIN_EMAIL}}#${ADMIN_EMAIL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{ADMIN_XMPP}}#${ADMIN_XMPP}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/prosody.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/components.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/components.cfg.lua
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /etc/prosody/virtual-hosts.cfg.lua
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /etc/prosody/virtual-hosts.cfg.lua
    sed -i "s#{{SECRET}}#${SECRET}#" /etc/prosody/prosody.cfg.lua

    mkdir -p /tmp/certs && mkdir -p /etc/prosody/certs

    # Prepare certificates to be in the default location where prosody expects them
    if [ -f /cert/acme.json ]; then
        traefik-certs-dumper file --source /cert/acme.json --dest /tmp/certs --version v2
        mv /tmp/certs/certs/${XMPP_SERVER_URL}.crt /tmp/certs/private/${XMPP_SERVER_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_GROUPS_URL}.crt /tmp/certs/private/${XMPP_GROUPS_URL}.key /etc/prosody/certs/
    fi

    # Eventually add virtual hosts
    hosts="${XMPP_HOST_URL_1} ${XMPP_HOST_URL_2} ${XMPP_HOST_URL_3}"
    for host in ${hosts}; do

        echo "Virtual host for: ${host}"

        if [ -f /tmp/certs/certs/${host}.crt ]; then
            mv /tmp/certs/certs/${host}.crt /tmp/certs/private/${host}.key /etc/prosody/certs/
        fi

        echo 'VirtualHost ("'${host}'")' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        http_external_url = "https://'${XMPP_SERVER_URL}'/"' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        ssl = {' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '                certificate = "/etc/prosody/certs/'${host}'.crt";' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '                key = "/etc/prosody/certs/'${host}'.key";' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        }' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        disco_items = {' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '                { "'${XMPP_GROUPS_URL}'", "A group chat (muc) service" };' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '        }' >> /etc/prosody/virtual-hosts.cfg.lua
        echo '' >> /etc/prosody/virtual-hosts.cfg.lua
    done

    # Make sure everything has the right owner
    chown -R prosody:prosody /etc/prosody/certs
    chown -R prosody:prosody /var/lib/prosody/data

    # Go jabber go
    prosodyctl start
fi
