# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/dashboard ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/agent
echo '{"databases": []}' > ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/agent/databases.json
