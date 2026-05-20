# setup_before_up.sh
#! /bin/bash

set -a; source .env; set +a

echo "mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}"
mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}

echo "cp ./install-conf.yml ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}"
cp ./install-conf.yml ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}
