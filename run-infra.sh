#!/bin/bash

ACTION=$1
echo "Action: $ACTION"

USER_NAME=$(whoami)
echo "User ID: $USER_NAME"

# print current user id and group id and export them
# For some container run as root, we need to pass the current user id and group id to the container
echo "Current user id: $(id -u)"
echo "Current group id: $(id -g)"
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Define source and destination directories
TARGET_DIR="/Users/$USER_NAME/Documents/docker-data"
NGINX_SRC="./nginx1x"
REDIS_SRC="./redis"

export NGINX_DEST="$TARGET_DIR/nginx1x"
export REDIS_DEST="$TARGET_DIR/redis"
export MONGO_DB_DEST="$TARGET_DIR/mongo/data/db"
export MONGO_CONF_DEST="$TARGET_DIR/mongo/data/configdb"

# Create destination directories if they do not exist
mkdir -p $TARGET_DIR
mkdir -p $MONGO_DB_DEST
mkdir -p $MONGO_CONF_DEST

# Copy nginx and redis folders to the destination directories
cp -r $NGINX_SRC $TARGET_DIR
cp -r $REDIS_SRC $TARGET_DIR
mkdir -p "$NGINX_DEST/log"

echo "Target directory: $TARGET_DIR"
echo "Nginx at $NGINX_DEST"
echo "Redis at $REDIS_DEST"

echo "Starting or stop the docker containers..."
if [ "$ACTION" == "stop" ]; then
  docker-compose -f docker-compose_infra.yaml down --remove-orphans
  exit
fi
docker-compose -f docker-compose_infra.yaml up -d