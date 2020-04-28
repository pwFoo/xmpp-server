-- This is the list of modules Prosody will load on startup.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {

	-- General server modules
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"saslauth"; -- Authentication for clients and servers.
		"tls"; -- Add support for secure TLS on connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		-- "http_upload_external"; -- Upload files to a server and share with others.
		"bosh"; -- Enable BOSH ("XMPP over HTTP") for web clients 
		-- "websocket"; -- Websockets are cool, but probably not ready, yet.
		-- "http_files"; -- Serve static files from a directory over HTTP

	-- Admin interface modules
		-- "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		-- "admin_telnet"; -- Opens telnet console interface on localhost port 5582

	-- User modules
		"roster"; -- Allow users to have a roster.
		"vcard"; -- Allow users to set vCards
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"offline"; -- Store offline messages
		"blocklist"; -- Support privacy lists
		"blocking"; -- Allow users to block communications with other users
		-- "pep"; -- Enables users to publish their mood, activity, playing music and more
		"pep_simple"; -- Old pep implementation, until omemo_all_access supports it
		"mam"; -- Store chat history server sided.
		--"groups"; -- Shared roster support
		--"announce"; -- Send announcement to all online users
		--"motd"; -- Send a message to users when they log in

	-- Registration	modules
		"register"; -- Allow users to register on this server using a client and change passwords
		"register_web"; -- Allow users to register online
		"watchregistrations"; -- Alert admins of registrations
		--"welcome"; -- Welcome users who register accounts

    -- Community modules (let's have a modern chat server)
		"csi_battery_saver"; -- Hold unimportant stanzas until client comes online. 
		"cloud_notify"; -- "Push notifcations" for new messages
		"invite"; -- Allows users to invite new users
		"smacks"; -- Support for unstable (mobile) Networks
		"carbons"; -- Syncing of messages between compatible devices
}
