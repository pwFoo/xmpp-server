-- Standard host
VirtualHost ("{{XMPP_SERVER_URL}}")

        http_host = "{{XMPP_SERVER_URL}}"
        http_external_url = "https://{{XMPP_SERVER_URL}}"
        disco_items = {
                { "{{XMPP_GROUPS_URL}}", "A group chat (muc) service" };
            }
