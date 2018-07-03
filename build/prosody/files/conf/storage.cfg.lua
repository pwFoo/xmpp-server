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

-- https://modules.prosody.im/mod_mam.html
archive_expires_after = "1y"
