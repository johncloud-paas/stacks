# setup_after_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a
(
    echo "chown 2000:2000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/" &&
    sudo chown 2000:2000 -R $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME/
)
