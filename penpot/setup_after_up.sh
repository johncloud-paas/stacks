# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo "mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/assets"
sudo mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/assets

echo "chown 1001:1001 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/assets"
sudo chown 1001:1001 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/assets

echo "chmod -R 755 $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/assets"
sudo chmod -R 755 $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/assets
