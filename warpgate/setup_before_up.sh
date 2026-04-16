# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo "mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data"
sudo mkdir -p $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data

echo "cp warpgate.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data"
cp warpgate.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/data
