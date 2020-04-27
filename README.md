# XMPP server distribution

Easy to setup and full featured [XMPP](https://xmpp.org/) server based on Docker Compose using open technology for real-time communication.


## Idea

Everybody needs an open communication tool without walls and gated communities. This configuration allows you to setup a solid full working jabber/xmpp server without much hassle.

## Components

[Docker](https://www.docker.com/) images containing the [Prosody](https://prosody.im) server and the web client [Converse.js](https://conversejs.org/). It is orchestrated by the reverse proxy [traefik](https://traefik.io) and provides out-of-the-box secure connections with certificates by [Let's Encrypt](https://letsencrypt.org). It is connected to [prosody-filer](https://github.com/ThomasLeister/prosody-filer) for comfortable file upload and exchange. In addition it includes it own [coturn](https://github.com/coturn/coturn) service to support audio and video calls.

## Installation

Before you start, you have to configure your domain's **dynamic name server (DNS) settings**. Basically you need one A record pointing to the server and a couple of CNAME records for each additional subdomain we need (for group chat and the web client) pointing to the domain of the server:


```
xmpp.example.com.            A        XXX.XXX.XXX.XXX        (XMPP_SERVER_URL)
conference.xmpp.example.com. CNAME    xmpp.example.com.      (XMPP_GROUPS_URL)
chat.example.com.            CNAME    xmpp.example.com.      (XMPP_WEBCLIENT_URL)
```

After this, you can **install the xmpp server** just with a few easy steps:

* Make sure you have recent versions [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) working.
* Copy over the [configuration file](./env-example) and edit it: `cp env-example .env`
* Run docker compose to spin it all up: `docker-compose up -d`

Done.

## Variables

Only some variables you have to specify in the [configuration file](./env-example).

* `NAME`: A freely chooseable name (required)
* `SECRET`:  A freely definable common secret for the components to interact (required)
* `XMPP_ADMIN`: XMPP account of the server's administrator (required)
* `XMPP_SERVER_URL`: Domain for the xmpp server (required)
* `XMPP_GROUPS_URL`: Domain for the group chat (muc) server (required)
* `XMPP_WEBCLIENT_URL`: Domain for the web chat client (required)
* `TURN_SERVER_URL`: Domain for the turn server (required)
* `XMPP_HOST_URL_1`, `XMPP_HOST_URL_2` and `XMPP_HOST_URL_3`: Virtual hosts for xmpp addresses (optional)


### License

This is Free and Open Source Software. Released under the [MIT license](./LICENSE.md). You can use, study share and improve it at your will. Any [contribution](./CONTRIBUTING.md) is highly appreciated. Only together we can make the world a better place.
