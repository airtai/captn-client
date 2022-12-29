#!/bin/bash

source set_variables.sh

docker-compose -p $DOCKER_COMPOSE_PROJECT -f $DOWNLOAD_FILE_DESTINATION -f docker/client.yml --profile dev down
