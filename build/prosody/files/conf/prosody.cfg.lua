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
    register_web = "/_xmpp/register";
    pastebin = "_xmpp/pastebin";
    upload = "/_xmpp/upload";
    websocket = "/_xmpp/websocket"
}

-- Registration settings
-- Allow only one registration every 5 minutes
allow_registration = true
registration_throttle_max = 1
registration_throttle_period = 300
register_web_template = "/usr/lib/prosody-register-web-template"

-- BOSH and websocket settings
cross_domain_bosh = "*";
cross_domain_websocket = true;
consider_websocket_secure = true;
consider_bosh_secure = true

-- MAM
archive_expires_after = "1y"

-- HTTP upload settings
http_upload_external_base_url = "https://{{XMPP_SERVER_URL}}/_xmpp/upload/"
http_upload_external_secret = "{{SECRET}}"
http_upload_external_file_size_limit = 50000000 -- 50 MB


-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.
authentication = "internal_plain"

storage = {
  archive2 = "sql";
}

sql = { driver = "SQLite3", database = "prosody.sqlite3" }

-- Most of configuration is split up in separate files
Include "modules.cfg.lua";
Include "components.cfg.lua";
Include "virtual-hosts.cfg.lua";

-- Include configuration to be added if needed (for example for more hosts)
Include "conf.d/*.cfg.lua";
