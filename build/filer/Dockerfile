FROM debian:stretch-slim

EXPOSE 80
VOLUME ["/app/upload"]

ENV DEBIAN_FRONTEND noninteractive

# Install prosody-filer
RUN apt-get update --yes && apt-get install --yes wget
RUN wget -q https://github.com/ThomasLeister/prosody-filer/releases/download/v1.0.0-rc2/prosody-filer_v1.0.0-rc2_linux_x64.0_linux_x64 -O /app/prosody-filer
RUN chmod +x /app/prosody-filer
COPY files/config.toml /app/config.toml
COPY files/start.sh /start.sh

# Clean up
RUN apt-get purge wget --yes && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TOOD: Implement regular (cron) job to automatically purge and clean up old files.

WORKDIR /app
CMD [ "/start.sh" ]
