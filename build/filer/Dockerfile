FROM debian:bullseye-slim

EXPOSE 5050
VOLUME ["/app/uploads"]

ENV DEBIAN_FRONTEND noninteractive

# Install xmpp-filer
RUN apt-get update --yes && apt-get install --yes golang-go git wget
RUN go get github.com/xamanu/xmpp-filer
RUN cd /root/go/src/github.com/xamanu/xmpp-filer && ./build.sh
RUN mv /root/go/src/github.com/xamanu/xmpp-filer/prosody-filer /app/xmpp-filer

RUN chmod +x /app/xmpp-filer
COPY files/config.toml /app/config.toml
COPY files/start.sh /start.sh

# Clean up
RUN apt-get purge wget --yes && apt-get autoremove --yes && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TOOD: Implement regular (cron) job to automatically purge and clean up old files.

WORKDIR /app
CMD [ "/start.sh" ]
