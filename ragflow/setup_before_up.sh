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
    mkdir -p $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/es_data &&
    echo "cp entrypoint.sh $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME" &&
    cp entrypoint.sh $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME &&

    echo "cp service_conf.yaml.template $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME" &&
    cp service_conf.yaml.template $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME &&

    echo "chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/es_data" &&
    chown 1000:1000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/es_data
)
