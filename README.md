Create networks

    sudo docker network create -d bridge --subnet=192.168.203.0/24 traefik-proxy 

To start/restart a service

    ./restart.sh <service_name>
    