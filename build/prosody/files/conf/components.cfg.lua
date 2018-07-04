-- Set up a MUC (multi-user chat) room server:
Component ("{{XMPP_GROUPS_URL}}") "muc"

    name = "Groups"
    restrict_room_creation = false
    modules_enabled = { 
            "mam_muc"; -- Store mucs' chat history server sided.
            "vcard_muc"; -- Avatars for group chats
            "pastebin"; -- Move long texts to a simple http server
    }
    pastebin_trigger = "!paste"
    pastebin_line_threshold = 12
    pastebin_url="https://{{XMPP_SERVER_URL}}/_xmpp/pastebin/"

    ssl = {
            key = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.key";
            certificate = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.crt";
    }
