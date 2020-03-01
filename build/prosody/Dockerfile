FROM debian:buster-slim

VOLUME ["/etc/prosody"]
VOLUME ["/var/lib/prosody"]

# 5000/tcp: mod_proxy65
# 5222/tcp: client to server
# 5223/tcp: deprecated, SSL client to server
# 5269/tcp: server to server
# 5280/tcp: http server (bosh, http_upload, etc.)
# 5347/tcp: XMPP component
EXPOSE 5222 5223 5269 5280

ENV DEBIAN_FRONTEND noninteractive

# Add backports repository
RUN printf "deb http://deb.debian.org/debian buster-backports main main non-free" > /etc/apt/sources.list.d/backports.list

# Install software
RUN apt-get update --yes && apt-get install -y --no-install-recommends \
        bash \
        lsb-base \
        procps \
        adduser \
        libidn11 \
        libicu63 \
        libssl1.1 \
        lua-bitop \
        lua-dbi-mysql \
        lua-dbi-postgresql \
        lua-dbi-sqlite3 \
        lua-event \
        lua-expat \
        lua-filesystem \
        lua-sec \
        lua-socket \
        lua-zlib \
        lua5.1 \
        lua5.2 \
        openssl \
        ca-certificates \
        ssl-cert \
        mercurial \
        git \
    && apt-get -t buster-backports install prosody \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Adding additional prosody modules
RUN service prosody stop
WORKDIR /usr/lib/
RUN hg clone https://hg.prosody.im/prosody-modules/
RUN git clone https://github.com/xamanu/prosody-register-web-template.git prosody-register-web-template

RUN mkdir -p /var/run/prosody && chown prosody:prosody /var/run/prosody

# Add necessary scripts
ADD files/start.sh /start.sh
ADD files/dumpcerts.sh /dumpcerts.sh

# Place configuration
RUN mkdir -p /etc/prosody/conf.d && mkdir -p /etc/prosody/certs
COPY files/conf/* /etc/prosody/

#USER prosody
CMD [ "/start.sh" ]
