-- Set up a MUC (multi-user chat) room server:
Component ("{{XMPP_GROUPS_URL}}") "muc"

    name = "Groups"
    restrict_room_creation = false
    modules_enabled = { 
            "mam_muc"; -- Store mucs' chat history server sided.
            "vcard_muc"; -- Avatars for group chats
    }

    ssl = {
            key = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.key";
            certificate = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.crt";
    }
