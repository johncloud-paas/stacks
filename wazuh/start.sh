#!/bin/bash

set -a; source .env; set +a

sudo rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME

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

sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/api_configuration
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/etc
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/logs
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/queue
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/var_multigroups
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/integrations
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/active_response
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/agentless
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/wodles
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/filebeat_etc
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/filebeat_var
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_cluster
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/indexer-data
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_indexer
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/dashboard-config
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/dashboard-custom
sudo chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/config/wazuh_dashboard

sudo docker compose down &&
sudo docker compose pull &&
sudo docker compose up -d --remove-orphans &&
sudo docker compose logs -f
