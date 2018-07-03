#!/bin/sh

# Check if required variables are available
if [ -z "${XMPP_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_SERVER_URL must be set."
elif [ -z "${XMPP_GROUPS_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_GROUPS_URL must be set."
elif [ -z "${NAME}" ]; then
    echo "Failure starting xmpp server: The environment variable NAME must be set."
else

    sed -i "s#{{NAME}}#${NAME}#" /usr/src/app/dev_config.json
    sed -i "s#{{XMPP_SERVER_URL}}#${XMPP_SERVER_URL}#" /usr/src/app/dev_config.json
    sed -i "s#{{XMPP_GROUPS_URL}}#${XMPP_GROUPS_URL}#" /usr/src/app/dev_config.json

    npm start
fi