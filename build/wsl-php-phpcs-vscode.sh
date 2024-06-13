#!/bin/bash

# Executar no WSL
set -euxo pipefail

COMPOSE_PROJECT_NAME=$(grep COMPOSE_PROJECT_NAME ../.env | cut -d'=' -f2)

BUILD="/usr/local/bin"
PHP_CONTAINER_NAME=$COMPOSE_PROJECT_NAME-php-1
USER_ID_CONTAINER=$UID

# #######################
# ajustes para o vscode funcionar corretamente com os plugins de php e phpcs
# #######################

# php
SERVICE_PHP="$BUILD/php"
echo "docker exec -i --user=$USER_ID_CONTAINER:$USER_ID_CONTAINER $PHP_CONTAINER_NAME php \"\$@\"" > $SERVICE_PHP
chmod +x $SERVICE_PHP
chown -R $USER_ID_CONTAINER:$USER_ID_CONTAINER $SERVICE_PHP

#phpcs
SERVICE_PHPCS="$BUILD/phpcs"
echo "docker exec -i --user=$USER_ID_CONTAINER:$USER_ID_CONTAINER $PHP_CONTAINER_NAME phpcs \"\$@\"" > $SERVICE_PHPCS
chmod +x $SERVICE_PHPCS
chown -R $USER_ID_CONTAINER:$USER_ID_CONTAINER $SERVICE_PHPCS
