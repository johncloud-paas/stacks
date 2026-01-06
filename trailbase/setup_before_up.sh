# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo "mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data"
sudo mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data

echo "chown 1000:1000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}"
chown 1000:1000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}
