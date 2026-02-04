# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

mkdir -p ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/{config,downloads,jobs,server}
chown 1000:1000 -R ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/{config,downloads,jobs,server}
