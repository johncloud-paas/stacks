#!/bin/bash

sudo docker compose -f $1.yml down
sudo docker compose -f $1.yml up -d --remove-orphans
sudo docker compose -f $1.yml logs -f
