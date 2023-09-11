Base setup tutorial: https://github.com/traefik/traefik/issues/7825

Google OAuth setup: https://www.libe.net/en-traefik-auth

First initialize the swarm:

    sudo docker swarm init
    sudo docker network create -d overlay agent_network
    sudo docker network create --subnet=192.168.203.0/24 -d overlay public
    
Define the root data folder in a .env file, 

    git clone https://github.com/ydethe/johncloud_paas.git
    cd johncloud_paas
    echo "JOHNCLOUD_ROOT=/path/to/root/of/paas/data" > .env

Then define all the `.env` files, for each service, using `sample.env` as template

For backup management, see https://velero.io/docs/v1.12
For online docs editing, this is interesting (though already in nextcloud) : https://www.onlyoffice.com/

https://www.libe.net/en-docker-swarm-portainer-traefik

https://docs.portainer.io/start/install-ce/server/setup

https://blog.christian-schou.dk/set-up-traefik-with-docker-swarm/

