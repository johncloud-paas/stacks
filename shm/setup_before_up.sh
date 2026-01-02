# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

mkdir -p migrations
curl -sL https://raw.githubusercontent.com/btouchard/shm/main/migrations/001_init.sql -o migrations/001_init.sql
curl -sL https://raw.githubusercontent.com/btouchard/shm/main/migrations/002_applications.sql -o migrations/002_applications.sql
