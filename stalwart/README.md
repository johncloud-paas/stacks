Copy config.toml to `$JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/data/etc`

sudo docker exec stalwart-mailserver-1 stalwart-cli -u http://192.168.203.xxx:8080 -c admin:xxx server delete-config security.ip-blocked.192.168.203.xxx
sudo docker exec stalwart-mailserver-1 stalwart-cli -u http://192.168.203.xxx:8080 -c admin:xxx server reload-config

