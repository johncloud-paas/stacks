# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a
(
    echo "chown 1000:1000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/media" &&
    chown 1000:1000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/media &&

    echo "chown 1000:1000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/cache" &&
    chown 1000:10000 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/cache &&

    echo "chown 1000:0 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/es" &&
    chown 1000:0 -R $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}/es
)