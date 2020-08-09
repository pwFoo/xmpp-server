FROM debian:buster-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -y curl

RUN curl -O https://eturnal.net/download/package/eturnal_1.1.0-1_amd64.deb
RUN dpkg -i eturnal_1.1.0-1_amd64.deb

# Pull traefik-certs-dumper to convert acme.json suitable cert files
RUN curl -ssL https://github.com/ldez/traefik-certs-dumper/releases/download/v2.7.0/traefik-certs-dumper_v2.7.0_linux_amd64.tar.gz | tar xvfz - -C /usr/local/bin traefik-certs-dumper && \
    chmod +x /usr/local/bin/traefik-certs-dumper && \
    mkdir -p /etc/eturnal/tls/

EXPOSE 3478 3478/udp
EXPOSE 5349 5349/udp

COPY ./files/eturnal.yml /etc/
COPY ./files/start.sh /

ENTRYPOINT ["/start.sh"]
