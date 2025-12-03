# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo "mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/config"
sudo mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/config

echo "cp teleport.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/config"
cp teleport.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/config

echo "chown 1001:1001 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}"
chown 1001:1001 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}
