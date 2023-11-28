From https://docs.funkwhale.audio/administrator/installation/docker.html#set-up-funkwhale

Run the database migrations

    sudo docker compose run --rm api funkwhale-manage migrate

Create your superuser.

    sudo docker compose run --rm api funkwhale-manage createsuperuser
