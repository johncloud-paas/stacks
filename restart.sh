#!/bin/bash

sudo docker compose -f $1.yml -p $1 down
sudo docker compose -f $1.yml -p $1 up -d --remove-orphans
sudo docker compose -f $1.yml -p $1 logs -f
