#! /bin/sh

sudo docker stack rm wordpress
env $(cat .env | xargs) envsubst < ./docker-compose.yml | sudo docker stack config --compose-file - 
env $(cat .env | xargs) envsubst < ./docker-compose.yml | sudo docker stack deploy --compose-file - wordpress
sudo docker service logs wordpress_wordpress -f
