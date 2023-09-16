# OpenVPN stack for [Johncloud PaaS](https://github.com/johncloud-paas)

Website: https://openvpn.net/
Container: https://dockovpn.io/docs/quickstart/

## Installation

First, prepare the DNS. You shall add a CNAME or A record for `vpn.domain.tld`

Second, have your environment variables written in a file. Take sample.env in this repository as an example.

Finally, follow the guide here to deploy the stack: https://docs.portainer.io/user/docker/stacks/add#option-3-git-repository

## Administration

You can add a user from the CLI with:

    sudo docker compose exec admin flask mailu user user domain.tld 'clear-strong-password'
