-- This is the list of modules Prosody will load on startup.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {

	-- Generally required
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.

	-- Not essential, but recommended
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard"; -- Allow users to set vCards
		"offline"; -- Store offline messages

	-- These are commented by default as they have a performance impact
		"blocklist"; -- Support privacy lists
		"blocking"; -- Allow users to block communications with other users

	-- Nice to have
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"pep"; -- Enables users to publish their mood, activity, playing music and more
		"register"; -- Allow users to register on this server using a client and change passwords
		"register_web"; -- Allow users to register online
		"watchregistrations"; -- Alert admins of registrations

	-- HTTP modules
		"http_upload"; -- allow users to upload images to a central server. Active as a component.
		"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
		"websocket"; -- needed for Kaiwa
		--"http_files"; -- Serve static files from a directory over HTTP

	-- Admin interfaces
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		--"admin_telnet"; -- Opens telnet console interface on localhost port 5582

	-- Other specific functionality
		--"welcome"; -- Welcome users who register accounts
		--"groups"; -- Shared roster support
		--"announce"; -- Send announcement to all online users
		--"motd"; -- Send a message to users when they log in

    -- Others added by user
		"carbons"; -- Syncing of messages between compatible devices
		"smacks"; -- Support for unstable (mobile) Networks
		"csi"; -- Drop "less urgent" stanzas for mobile
		"throttle_presence"; -- define presence as "less urgent"
        "cloud_notify";
        "filter_chatstates"; -- disable "X is typing" type messages
		"mam"; -- store chat history server sided, IF clients request it.
		--"e2e_policy"; -- require end-2-end encryption
}

