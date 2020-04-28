FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

# Add dependencies
RUN apt-get update --yes && apt-get install --yes curl nginx python-twisted python-openssl

# Setup and install conversejs (https://conversejs.org) 

WORKDIR /tmp

# Download the conversejs app
RUN curl -L https://github.com/jcbrand/converse.js/archive/v0.9.5.tar.gz -o /tmp/conversejs_v0.9.5.tar.gz && \
  echo "94ea63c2fea4fd73e0c3f9fc8f48f2373da8b631 /tmp/conversejs_v0.9.5.tar.gz" | sha1sum -c - && \
  tar xfv /tmp/conversejs_v0.9.5.tar.gz && rm -f /tmp/conversejs_v0.9.5.tar.gz

# Clean up
RUN apt-get purge --yes curl && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Move everything in its place
RUN cp /tmp/converse.js-*/css/converse.min.css /usr/share/nginx/html/ && \
    cp /tmp/converse.js-*/builds/converse.min.js /usr/share/nginx/html/ && \
    rm /etc/nginx/conf.d/*

# Place configuration
COPY files/index.html /usr/share/nginx/html/
COPY files/site.conf /etc/nginx/conf.d/

COPY files/start.sh /start.sh

ENTRYPOINT ["/start"]
