# setup_before_up.sh
#! /bin/bash

set -a; source .env; set +a

echo `pwd`
echo "cp config.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}"
cp config.yaml $JOHNCLOUD_ROOT/${COMPOSE_PROJECT_NAME}
