# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

echo
read -p "Remove $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME ?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME"
    rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME
fi

(
    echo "mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/vespa_volume" &&
    mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/vespa_volume &&
    echo "chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/vespa_volume" &&
    chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/vespa_volume
)
