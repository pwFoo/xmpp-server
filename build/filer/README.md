Docker image for Prosody Filer
======================

Prosody filer is an external http upload service for [XMPP](https://xmpp.org) (a.k.a. Jabber), open technology for real-time communication.

This setup comes out-of-the-box with standard configuration. Only the following environment variable(s) need to be specified:

* `SECRET`: A common secret also specified in the xmmp server configuration, which allows this server to upload.

You can start this container with one single command:

`docker run --env SECRET="sh0B832ut0wCGqA43q09ewgty843riusHH0ufd" xama nu/filer` _(of course use your own secret!)_

This is image part of the easy to setup and full featured [xmpp server configuration](https://github.com/xamanu/xmpp-server) but can be used otherwise.


### Resources

 * [Report issues](/issues) and [send Pull Requests](https://github.com/xamany/xmpp-server/pulls) in the [main xmpp-server repository](https://github.com/xamanu/xmpp-server).


### License

This is Free and Open Source Software. Released under the [MIT license](./LICENSE.md). You can use, study share and improve it at your will. Any contribution is highly appreciated. Together we can make the world a better place.
