# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

(
    echo "cp authentik.yaml $JOHNCLOUD_ROOT/traefik/conf.d" &&
    cp authentik.yaml $JOHNCLOUD_ROOT/traefik/conf.d &&

    echo "chown 65532:65532 $JOHNCLOUD_ROOT/traefik/conf.d/authentik.yaml" &&
    chown 65532:65532 $JOHNCLOUD_ROOT/traefik/conf.d/authentik.yaml &&

    echo "chmod 644 $JOHNCLOUD_ROOT/traefik/conf.d/authentik.yaml" &&
    chmod 644 $JOHNCLOUD_ROOT/traefik/conf.d/authentik.yaml
)
