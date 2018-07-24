# Domains

There are basically three options how host your setup and setups the domains and Dynamic Domain Server entries. All of them have advantages and disadvantages, mostly on how the xmpp address is formed and if or if not automatic certificate generation is possible. This is giving you a short overview, so you can take the most suitable decision for yourself before setting anything up:

#### 1. Main domain with automatic certificates

You can run the server on the main domain `example.com`and you get nicely formed user names like `felix@example.com`. This works perfectly out of the box and all certificates are generated automatically. 

The magic trick: Your main domain DNS record must point to the server where the xmpp server is running, and all http/s requests not related to the XMPP server are redirected to `www.example.com`.

To configure this option, just specify the configuration file `.env` accordingly:

```
XMPP_HOST_URL=example.com
XMPP_SERVER_URL=example.com
```

#### 2. Sub-domain

You can also run the server on a subdomain `xmpp.example.com`, but then you have to decide between two constraints:

##### a) Automatic certificate creation

The simple solution is that your users are formed with the sub-domain, like `felix@xmpp.example.com`. This works out of the box and all certificates are generated automatically.

To configure this option, just specify the configuration file `.env` accordingly:

```
XMPP_HOST_URL=xmpp.example.com
XMPP_SERVER_URL=xmpp.example.com
```

##### b) You provide the certificate for the main domain

However, if want the server to run on a subdomain `xmpp.example.com` and you still want have to have nicely formed user names like `felix@example.com` then you have to be in charge of providing this certificate, it can not be created automatically for you.

To configure this option, just specify the configuration file `.env` accordingly:

```
XMPP_HOST_URL=example.com
XMPP_SERVER_URL=xmpp.example.com
```
