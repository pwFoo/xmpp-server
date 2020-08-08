FROM debian:buster-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -y coturn curl

# Pull traefik-certs-dumper to convert acme.json suitable cert files
RUN curl -ssL https://github.com/ldez/traefik-certs-dumper/releases/download/v2.7.0/traefik-certs-dumper_v2.7.0_linux_amd64.tar.gz | tar xvfz - -C /usr/local/bin traefik-certs-dumper && \
    chmod +x /usr/local/bin/traefik-certs-dumper && \
    mkdir -p /etc/coturn/certs

EXPOSE 3478 3478/udp
EXPOSE 5349 5349/udp
EXPOSE 49152-65535 49152-65535/udp

COPY ./files/start.sh /
ENTRYPOINT ["/start.sh"]
