#! /bin/sh

sudo docker compose down
sudo rm -rf /home/yann/johncloud_data/auth
sudo docker system prune --all -f
sudo docker compose up -d --remove-orphans

