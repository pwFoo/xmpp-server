FROM debian:buster-slim

EXPOSE 5050
VOLUME ["/app/uploads"]

ENV DEBIAN_FRONTEND noninteractive

# Install xmpp-filer
RUN apt-get update --yes && apt-get install --yes wget
RUN wget -q https://github.com/ThomasLeister/prosody-filer/releases/download/v1.0.2/prosody-filer_linux_x86_64 -O /app/xmpp-filer
RUN chmod +x /app/xmpp-filer

COPY files/config.toml /app/config.toml
COPY files/start.sh /start.sh

# Clean up
RUN apt-get purge wget --yes && apt-get autoremove --yes && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TOOD: Implement regular (cron) job to automatically purge and clean up old files.

WORKDIR /app
CMD [ "/start.sh" ]
