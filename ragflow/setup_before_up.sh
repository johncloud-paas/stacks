# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

read -p "Remove $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME"
    rm -rf $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME
fi

echo "cp entrypoint.sh $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME"
cp entrypoint.sh $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME

echo "cp service_conf.yaml.template $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME"
cp service_conf.yaml.template $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME
