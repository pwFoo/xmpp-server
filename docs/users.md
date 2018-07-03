# Manage users

#### Register a new user in one command
docker exec -it xmpp-server_xmpp-server_1 prosodyctl register USERNAME EXAMPLE-DOMAIN.TLD PASSWORD

#### Add user
docker exec -it xmpp-server_xmpp-server_1 prosodyctl adduser USERNAME@EXAMPLE-DOMAIN.TLD

#### Change password
docker exec -it xmpp-server_xmpp-server_1 prosodyctl passwd USERNAME@EXAMPLE-DOMAIN.TLD

#### Delete user
docker exec -it xmpp-server_xmpp-server_1 prosodyctl deluser USERNAME@EXAMPLE-DOMAIN.TLD


