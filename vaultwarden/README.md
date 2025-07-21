# Admin page

https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page

    passwd | argon2 "$(openssl rand -base64 32)" -e -id -k 19456 -t 2 -p 1
    echo "generated string" | sudo docker secret create vaultwarden_admin_token -

