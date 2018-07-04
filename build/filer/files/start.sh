#!/usr/bin/env bash

if [ -z "${SECRET}" ]; then
    echo "Failure starting prosody-filer: The environment variable SECRET must be set."
else

    sed -i "s#{{SECRET}}#${SECRET}#" /app/config.toml
    exec ./prosody-filer
fi