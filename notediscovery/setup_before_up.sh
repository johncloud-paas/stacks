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
    echo "mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/" &&
    mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/ &&

    echo "cp config.yaml $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME" &&
    cp config.yaml $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME

    echo "cp -r plugins themes locales $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME" &&
    cp -r plugins themes locales $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME
)
