-- Standard host
VirtualHost ("{{XMPP_SERVER_URL}}")

        -- HTTP Settings
        http_host = "{{XMPP_SERVER_URL}}"
        http_external_url = "https://{{XMPP_SERVER_URL}}"

---Set up a MUC (multi-user chat) room server on conference.example.com:
Component ("{{XMPP_GROUPS_URL}}") "muc"
        name = "Groups"
        restrict_room_creation = false
        modules_enabled = { 
                "pastebin" 
                --"mam_muc"; -- MAM for MUC
        }
        pastebin_trigger = "!paste"
        pastebin_line_threshold = 12
        ssl = {
                key = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.key";
                certificate = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.crt";
        }

-- TODO
-- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
-- Component "proxy65.{{XMPP_SERVER_URL}}" "proxy65"

-- Eventually more configuration added by the start.sh script
