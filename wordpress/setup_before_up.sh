#!/bin/bash

( source .env &&
  rm -rf ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/* &&
  chown -R 1001:1001 ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}
)
