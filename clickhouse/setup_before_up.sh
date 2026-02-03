# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo "mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/local"
sudo mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/local

cp local/* ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/local
