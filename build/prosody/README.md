Docker image for XMPP Prosody
======================

Prosody is a server for [XMPP](https://xmpp.org) - open technology for real-time communication.


This setup comes out-of-the-box with standard configuration. Only the following environment variables need to be specified:

* `NAME`: A freely chooseable name (required)
* `SECRET`:  A freely definable common secret for the components to interact (required)
* `XMPP_ADMIN`: XMPP account of the server's administrator (required)
* `XMPP_SERVER_URL`: Domain for the xmpp server (required)
* `XMPP_GROUPS_URL`: Domain for the group chat (muc) server (required)
* `XMPP_WEBCLIENT_URL`: Domain for the web chat client (required)
* `XMPP_HOST_URL_1`, `XMPP_HOST_URL_2` and `XMPP_HOST_URL_3`: Virtual hosts for xmpp addresses (optional)

You can start this container with one single command:

`docker run --env NAME="My setup" ... xamanu/xmpp-prosody`


This is image part of the easy to setup and full featured [xmpp server configuration](https://github.com/xamanu/xmpp-server) but can be used otherwise.


### Resources

 * [Report issues](/issues) and [send Pull Requests](https://github.com/xamany/xmpp-server/pulls) in the [main xmpp-server repository](https://github.com/xamanu/xmpp-server).


### License

This is Free and Open Source Software. Released under the [MIT license](./LICENSE.md). You can use, study share and improve it at your will. Any contribution is highly appreciated. Together we can make the world a better place.
