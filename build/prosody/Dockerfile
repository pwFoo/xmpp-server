FROM debian:stretch-slim

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

# Install software
RUN \
    apt-get update --yes && apt-get install --yes \
        bash \
        ca-certificates \
        coreutils \
        jq \
        libicu57 \
        lua-zlib \
        lua-ldap \
        lua-sql-sqlite3 \
        lua-dbi-sqlite3 \
        lua-event \
        lua5.1 \
        lua-expat \
        lua-filesystem \
        lua-sec \
        lua-bitop \
        ssl-cert \
    && apt-get install --yes --no-install-recommends \ 
        mercurial \
        git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Add prosody developer repository for latest version
RUN apt-get update --yes && apt-get install --yes gnupg2 wget
RUN wget https://packages.prosody.im/debian/pool/main/p/prosody-trunk/prosody-trunk_1nightly1119-1~stretch_amd64.deb
RUN dpkg -i prosody-trunk_1nightly1119-1~stretch_amd64.deb
RUN rm prosody-trunk_1nightly1119-1~stretch_amd64.deb

RUN service prosody stop

# Adding additional prosody modules
WORKDIR /usr/lib/
RUN hg clone https://hg.prosody.im/prosody-modules/
RUN git clone https://github.com/xamanu/prosody-register-web-template.git prosody-register-web-template

# Add necessary scripts
ADD files/start.sh /start.sh
ADD files/dumpcerts.sh /dumpcerts.sh

# Place configuration
RUN mkdir -p /etc/prosody/conf.d && mkdir -p /etc/prosody/certs
COPY files/conf/* /etc/prosody/

#USER prosody
CMD [ "/start.sh" ]
