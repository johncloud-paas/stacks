# setup_before_up.sh
#! /bin/bash

cd $1

set -a; source .env; set +a

sudo sysctl -w vm.max_map_count=262144

sudo mkdir -p \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/api_configuration \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/etc \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/logs \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/queue \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/var_multigroups \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/integrations \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/active_response \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/agentless \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/wodles \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/filebeat_etc \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/filebeat_var \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/dashboard-config \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/dashboard-custom \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_dashboard \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/indexer-data \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_cluster \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_indexer &&
sudo cp ./config/wazuh_cluster/wazuh_manager.conf ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_cluster/wazuh_manager.conf &&
sudo cp ./config/wazuh_indexer/wazuh.indexer.yml ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_indexer/wazuh.indexer.yml &&
sudo cp ./config/wazuh_indexer/internal_users.yml ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_indexer/internal_users.yml &&
sudo cp ./config/wazuh_dashboard/* ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_dashboard &&
sudo cp ./config/wazuh_dashboard/opensearch_dashboards.yml ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_dashboard &&
sudo chown -R 0:0  \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/api_configuration \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/etc \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/logs \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/queue \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/var_multigroups \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/integrations \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/active_response \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/agentless \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/wodles \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/filebeat_etc \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/filebeat_var &&
sudo chown -R 1000:1000  \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/indexer-data \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_cluster \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_indexer \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/dashboard-config \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/dashboard-custom \
${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_dashboard &&
sudo chmod 600 ${JOHNCLOUD_ROOT}/${COMPOSE_PROJECT_NAME}/config/wazuh_indexer/internal_users.yml

