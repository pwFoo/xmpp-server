-- Prosody XMPP Server Configuration
--
---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

admins = { "{{XMPP_ADMIN}}" }

-- Paths for data and modules
data_path = "/var/lib/prosody/data"
plugin_paths = { "/usr/lib/prosody-modules" }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = true

-- Disallow to run as a daemon. Necessary in a docker setup.
daemonize = false;

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.
c2s_require_encryption = true

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- NOTE: Your version of LuaSec must support certificate verification!
-- For more information see http://prosody.im/doc/s2s#security
s2s_secure_auth = false

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.
--
-- Let's just trust the big guys.
s2s_insecure_domains = { "gmail.com", "googlemail.com" }

-- Even if you leave s2s_secure_auth disabled, you can still require valid
-- certificates for some domains by specifying a list here.
--s2s_secure_domains = { "jabber.org" }

ssl = {
    key = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.key";
    certificate = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.crt";
}


-- Required for init scripts posix and prosodyctl
pidfile = "/var/run/prosody/prosody.pid"

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = {
    {levels = {min = "info"}, to = "console"};
};

-- HTTP Settings
-- bind to traditional BOSH port on localhost only, don't use HTTPS
-- as this sits behind a reverse proxy that handles HTTPS.
http_ports = { 5280 };
http_interfaces = { "0.0.0.0" };
https_ports = {};
https_interfaces = {};
http_paths = {
    bosh = "/_xmpp/http-bind"; 
    files = "/_xmpp/files";
    upload = "/_xmpp/upload";
    register_web = "/_xmpp/register";
    websocket = "/_xmpp/websocket"
}

-- Registration settings
-- Allow only one registration every 5 minutes
allow_registration = true
registration_throttle_max = 1
registration_throttle_period = 300
register_web_template = "/usr/lib/prosody-register-web-template"

cross_domain_bosh = "*";
cross_domain_websocket = true;
consider_websocket_secure = true;
consider_bosh_secure = true

-- Most of configuration is split up in separate files
Include "modules.cfg.lua";
Include "storage.cfg.lua";
Include "e2e-policy.cfg.lua";
Include "standard-host.cfg.lua";

-- Include configuration to be added if needed (for example for more hosts)
Include "conf.d/*.cfg.lua";
