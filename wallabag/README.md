# Create user

    sudo docker exec $(sudo docker ps -q -f name=wallabag_wallabag) /var/www/wallabag/bin/console fos:user:create --env=prod --super-admin admin <email> <password>
