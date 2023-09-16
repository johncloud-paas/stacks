#!/bin/bash

( cd $1 &&
sudo docker compose down &&
sudo docker compose up -d --remove-orphans &&
sudo docker compose logs -f
)
