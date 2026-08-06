#! /bin/bash

sudo mkdir -p /var/johncloud/revika/data
sudo rm -rf /var/johncloud/revika/data/*
sudo chown -R 65532:65532 /var/johncloud/revika/data

sudo docker compose -f docker-compose-std.yml pull
sudo docker compose -f docker-compose-std.yml down
sudo docker compose -f docker-compose-std.yml up -d --force-recreate --remove-orphans
sudo docker compose -f docker-compose-std.yml logs -f
