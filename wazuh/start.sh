#!/bin/bash

set -a; source .env; set +a

read -p "Erase $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME ? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME
fi

sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/api_configuration
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/etc
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/logs
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/queue
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/var_multigroups
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/integrations
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/active_response
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/agentless
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/wodles
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/filebeat_etc
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/filebeat_var
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_cluster
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/indexer-data
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_indexer
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/dashboard-config
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/dashboard-custom
sudo mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_dashboard

sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME

cp ./config/wazuh_indexer/wazuh.indexer.yml $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_indexer
cp ./config/wazuh_indexer/internal_users.yml $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_indexer
cp ./config/wazuh_cluster/wazuh_manager.conf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_cluster/wazuh_manager.conf

sudo docker compose down &&
sudo docker compose pull &&
sudo docker compose up -d --remove-orphans &&
sudo docker compose logs -f manager
