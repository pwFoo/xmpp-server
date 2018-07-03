# DNS

Basically you need one A record pointing to the server and a couple of CNAME records for each additional subdomain we need (for group chat and the web client) pointing to the domain of the server:

```
XMPP_SERVER_URL.        A        XXX.XXX.XXX.XXX
XMPP_GROUPS_URL.        CNAME    XMPP_SERVER_URL.
XMPP_CLIENT_URL.        CNAME    XMPP_SERVER_URL.
```

In my case I use the same hostname (chat.example.com) for both group chats (MUC) and for the web client Kaiwa, as they work on different ports, there is no problem.

```
XMPP_SERVER_URL.        A        XXX.XXX.XXX.XXX
XMPP_GROUPS_URL.        CNAME    XMPP_SERVER_URL.
```
www.XMPP_SERVER_URL     A        YYY.YYY.YYY.YYY

_Often times and commonly SRV records are used in XMMP. For this setup they are not necessary. However, in case you still want to add them, please see the [official documentation of Prosody](https://prosody.im/doc/dns#srv_records)._