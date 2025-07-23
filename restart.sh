#! /bin/bash

cd $1 && \
( set -a; source .env; set +a; envsubst < docker-compose.yml ) > /tmp/$1-docker-compose.yml && \
# sudo docker compose pull && \
sudo docker stack deploy --compose-file /tmp/$1-docker-compose.yml $1
