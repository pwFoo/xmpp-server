#!/bin/sh

# Check if required variables are available
if [ -z "${TURN_SERVER_URL}" ]; then
    echo "Failure starting turn server: The environment variable TURN_SERVER_URL must be set."
elif [ -z "${SECRET}" ]; then
    echo "Failure starting turn server: The environment variable SECRET must be set."
else

    # Replace required variables with configuration
    sed -i "s#{{TURN_SERVER_URL}}#${TURN_SERVER_URL}#" /etc/turnserver.conf
    sed -i "s#{{SECRET}}#${SECRET}#" /etc/turnserver.conf

    # Replace optional variables with configuration
    # if [ -z "${TURN_HOST}" ]; then
    #    sed -i "s#{{TURN_HOST}}#${TURN_HOST}#" /etc/prosody/prosody.cfg.lua
    #else
    #    sed -i "s#{{TURN_HOST}}# #" /etc/prosody/prosody.cfg.lua
    #fi

    turnserver
    echo "TURN server running. IP: "
fi
