# Mailu stack for [Johncloud PaaS](https://github.com/johncloud-paas)

Website: https://mailu.io/2.0/
Container: ghcr.io/mailu

## Installation

First, prepare the DNS. You shall add a CNAME or A record for `mail.domain.tld`

Second, have your environment variables written in a file. Take sample.env in this repository as an example.

Finally, follow the guide here to deploy the stack: https://docs.portainer.io/user/docker/stacks/add#option-3-git-repository

## Administration

The initial login/password is: postmaster@<domain.tld> / PASSWORD

Users can be added via the admin interface. You can also add a user from the CLI with:

    sudo docker compose exec admin flask mailu user user domain.tld 'clear-strong-password'
