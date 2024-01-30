#!/bin/bash

( cd $1 &&
sudo docker compose down &&
(if test -f setup_before_up.sh; then
  sudo ./setup_before_up.sh
fi) &&
sudo docker compose pull &&
sudo docker compose up -d --remove-orphans &&
(if test -f setup_after_up.sh; then
  sudo ./setup_after_up.sh
fi) &&
sudo docker compose logs -f
)
