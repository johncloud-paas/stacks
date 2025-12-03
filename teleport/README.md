Initial setup :

    https://goteleport.com/docs/installation/docker/#configuration

Run

    sudo docker run --hostname localhost --rm --entrypoint=/usr/local/bin/teleport public.ecr.aws/gravitational/tbot-distroless:18.4.2 configure --roles=proxy,auth > ./teleport.yaml

Changer les droits

    chown 1001:1001 $JOHNCLOUD_ROOT/$COMPOSE_PROJECT_NAME

    sudo docker compose exec -it teleport tctl users add admin --roles=editor,access