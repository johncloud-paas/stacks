To start/restart a service

    ./restart.sh <service_name>
    
https://headscale.net/running-headscale-linux/#installation

To block an IP range :

    sudo iptables -I DOCKER-USER 1 -s  60.211.206.0/24 -j DROP

To log blocked ips:

    sudo iptables -A DOCKER-USER -j LOG --log-level info --log-prefix "IPTABLES-DROP: "
