# Nextcloud stack for [Johncloud PaaS](https://github.com/johncloud-paas)

Website: https://nextcloud.com/
Container: https://hub.docker.com/_/nextcloud

## Installation

First, prepare the DNS. You shall add a CNAME or A record for `cloud.domain.tld`

Second, have your environment variables written in a file. Take sample.env in this repository as an example.

Finally, follow the guide here to deploy the stack: https://docs.portainer.io/user/docker/stacks/add#option-3-git-repository

## Administration

To scan the content of the folder data:

    sudo docker exec -ti --user www-data nextcloud-app-1 /var/www/html/occ files:scan --all

If needed:

    convmv -f utf-8 -t utf-8 -r --notest --nfc --replace <nextcloud-data-folder>

To set phone region:

    sudo docker exec --user www-data nextcloud-app-1 php occ config:system:set default_phone_region --value="yourvalue"

For oauth2

    sudo docker exec --user www-data nextcloud-app-1 php occ config:app:set --value=0 user_oidc allow_multiple_user_backends
