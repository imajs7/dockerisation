#!/bin/bash

BASE_IMAGE_NAME=$1
PROD_IMAGE_NAME=$2
RELEASE_IMAGE_NAME=$3
RELEASE_CONTAINER_NAME=$4

docker build -t $BASE_IMAGE_NAME -f Dockerfile-dev ./

docker build -t $PROD_IMAGE_NAME -f Dockerfile-prod ./

docker build --build-arg BASE_IMAGE_NAME=$BASE_IMAGE_NAME --build-arg PROD_IMAGE_NAME=$PROD_IMAGE_NAME -t $RELEASE_IMAGE_NAME ./

docker run  -d -p 3000:3000 --name $RELEASE_CONTAINER_NAME $RELEASE_IMAGE_NAME