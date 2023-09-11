#!/bin/sh

sudo docker stack rm manager
git pull
sudo docker stack deploy --compose-file docker-compose.yml manager
sudo docker service ps manager_traefik --no-trunc

