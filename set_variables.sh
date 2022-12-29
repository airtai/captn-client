#!/bin/bash

export CAPTN_CLIENT_DOCKER=ghcr.io/airtai/airt-service-dev:latest

BRANCH=$(git branch --show-current)
if [ "$BRANCH" == "main" ]; then
    TAG=latest
elif [ "$BRANCH" == "dev" ]; then
    TAG=dev
else
    if [ "$(docker image ls -q $CAPTN_CLIENT_DOCKER:$BRANCH)" == "" ]; then
        TAG=dev
    else
        TAG=$BRANCH
    fi
fi

if [ "$BRANCH" == "main" ]; then
    AIRT_SERVICE_FILE_BRANCH=main
else
    AIRT_SERVICE_FILE_BRANCH=dev
fi

export TAG BRANCH AIRT_SERVICE_FILE_BRANCH

echo PORT_PREFIX variable set to $PORT_PREFIX

if test -z "$CAPTN_JUPYTER_PORT"; then
      echo 'CAPTN_JUPYTER_PORT variable not set, setting to 8888'
      export CAPTN_JUPYTER_PORT="${PORT_PREFIX}8888"
else
    echo CAPTN_JUPYTER_PORT variable set to $CAPTN_JUPYTER_PORT
fi

if test -z "$CAPTN_TB_PORT"; then
      echo 'CAPTN_TB_PORT variable not set, setting to 6006'
      export CAPTN_TB_PORT="${PORT_PREFIX}6006"
else
    echo CAPTN_TB_PORT variable set to $CAPTN_TB_PORT
fi

if test -z "$CAPTN_DASK_PORT"; then
      echo 'CAPTN_DASK_PORT variable not set, setting to 8787'
      export CAPTN_DASK_PORT="${PORT_PREFIX}8787"
else
    echo CAPTN_DASK_PORT variable set to $CAPTN_DASK_PORT
fi

if test -z "$CAPTN_DOCS_PORT"; then
      echo 'CAPTN_DOCS_PORT variable not set, setting to 4000'
      export CAPTN_DOCS_PORT="${PORT_PREFIX}4000"
else
      echo CAPTN_DOCS_PORT variable set to $CAPTN_DOCS_PORT
fi

if test -z "$CAPTN_DATA"; then
      echo 'CAPTN_DATA variable not set, setting to current directory'
      export CAPTN_DATA=`pwd`
fi
echo CAPTN_DATA variable set to $CAPTN_DATA

if test -z "$CAPTN_PROJECT"
then
      echo 'CAPTN_PROJECT variable not set, setting to current directory'
      export CAPTN_PROJECT=`pwd`
fi
echo CAPTN_PROJECT variable set to $CAPTN_PROJECT

if test -z "$CAPTN_GPU_PARAMS"
then
      echo 'CAPTN_GPU_PARAMS variable not set, setting to all GPU-s'
      export CAPTN_GPU_PARAMS="--gpus all"
fi
echo CAPTN_GPU_PARAMS variable set to $CAPTN_GPU_PARAMS

echo Using $CAPTN_CLIENT_DOCKER
docker image ls $CAPTN_CLIENT_DOCKER


export UID=$(id -u)
export GID=$(id -g)


# Check .env.dev.* file exists and copy from template if it does not exists
if [ ! -f .env.dev.config ]; then
      cp .env.template.config .env.dev.config
fi

if [ ! -f .env.dev.secrets ]; then
      cp .env.template.secrets .env.dev.secrets
      echo 'Please update the environment variable values in file .env.dev.config, .env.dev.secrets and rerun the script'
      exit -1
fi


# Run envsubst for .env.dev.* files
cp .env.dev.config /tmp/captn-client.env.dev.config && envsubst < /tmp/captn-client.env.dev.config > .env.dev.config && rm /tmp/captn-client.env.dev.config
cp .env.dev.secrets /tmp/captn-client.env.dev.secrets && envsubst < /tmp/captn-client.env.dev.secrets > .env.dev.secrets && rm /tmp/captn-client.env.dev.secrets
# Export values in .env.dev.* files as environment variables for validation
set -a && source .env.dev.config && source .env.dev.secrets && set +a


if test -z "$AIRT_SERVICE_SUPER_USER_PASSWORD"
then
      echo 'AIRT_SERVICE_SUPER_USER_PASSWORD variable not set, exiting'
      exit -1
fi

if test -z "$AIRT_TOKEN_SECRET_KEY"
then
      echo 'AIRT_TOKEN_SECRET_KEY variable not set, exiting'
      exit -1
fi

if test -z "$AIRT_SERVICE_SUPER_USER"
then
      export AIRT_SERVICE_SUPER_USER="kumaran"
      echo 'AIRT_SERVICE_SUPER_USER variable not set, setting to default super user name'
fi

if test -z "$CAPTN_SERVICE_USERNAME"
then
      export CAPTN_SERVICE_USERNAME="johndoe"
      echo CAPTN_SERVICE_USERNAME variable set to $CAPTN_SERVICE_USERNAME
fi

if test -z "$AWS_ACCESS_KEY_ID"
then
      echo 'AWS_ACCESS_KEY_ID variable not set, exiting'
      exit -1
fi

if test -z "$AWS_SECRET_ACCESS_KEY"
then
      echo 'AWS_SECRET_ACCESS_KEY variable not set, exiting'
      exit -1
fi

if test -z "$STORAGE_BUCKET_PREFIX"
then
      echo 'STORAGE_BUCKET_PREFIX variable not set, exiting'
      exit -1
fi

export AIRT_SERVER_DOCKER="ghcr.io/airtai/airt-service"
AIRT_SERVER_DOCKER=$AIRT_SERVER_DOCKER:$TAG

export AIRT_SERVICE_PORT="${PORT_PREFIX}6007"
echo AIRT_SERVICE_PORT variable set to $AIRT_SERVICE_PORT

export DOMAIN="${USER}-airt-service"
echo DOMAIN variable set to $DOMAIN

export DROP_MESSAGES="--drop-messages"
echo DROP_MESSAGES variable set to $DROP_MESSAGES

export CAPTN_SERVER_URL="http://airt-service:6006"
echo CAPTN_SERVER_URL variable set to $CAPTN_SERVER_URL

export DOCKER_COMPOSE_PROJECT="${USER}-captn-client"
echo DOCKER_COMPOSE_PROJECT variable set to $DOCKER_COMPOSE_PROJECT

export AIRT_SERVER_GITLAB_ID=29120234
echo AIRT_SERVER_GITLAB_ID variable set to $AIRT_SERVER_GITLAB_ID

export URI_ENCODED_FILE_PATH="docker%2Fdependencies%2Eyml"
echo URI_ENCODED_FILE_PATH variable set to $URI_ENCODED_FILE_PATH

export DOWNLOAD_FILE_DESTINATION="docker/dependencies.yml"
echo DOWNLOAD_FILE_DESTINATION variable set to $DOWNLOAD_FILE_DESTINATION

export PRESERVE_ENVS=$(cat .env.dev.* | cut -f1 -d"=" | sed '/^#/d' |  tr '\n' ',')
export PRESERVE_ENVS="${PRESERVE_ENVS}CAPTN_SERVER_URL,CAPTN_SERVICE_USERNAME,CAPTN_SERVICE_PASSWORD,AIRT_SERVICE_SUPER_USER"
# echo $PRESERVE_ENVS
