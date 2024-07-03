Edit `/etc/docker/daemon.json`:

    {
    "log-driver": "journald"
    }

Then restart:

    sudo systemctl restart docker.service
