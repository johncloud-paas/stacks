Set `vm.max_map_count` by adding or updating the vm.max_map_count value in `/etc/sysctl.conf` accordingly:

    vm.max_map_count=262144
    sudo sysctl -p
    sudo systemctl restart docker

admin@ragflow.io / admin
