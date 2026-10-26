# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/data ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/logs
chown -R 101999:101999 ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/data ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/logs
