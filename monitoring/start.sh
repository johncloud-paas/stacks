#! /bin/sh

sudo docker stack rm monitoring
env $(cat .env | xargs) envsubst < ./docker-compose.yml | sudo docker stack config --compose-file - 
env $(cat .env | xargs) envsubst < ./docker-compose.yml | sudo docker stack deploy --compose-file - monitoring
sudo docker service logs monitoring_promtail -f
