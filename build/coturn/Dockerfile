FROM debian:stretch-slim

EXPOSE 3478 3478/udp

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --yes && apt-get install -y --no-install-recommends \
        dnsutils \
        coturn \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/turnserver.conf /etc/turnserver.conf
COPY files/start.sh /start.sh

ENTRYPOINT ["bash", "/start.sh"]    
