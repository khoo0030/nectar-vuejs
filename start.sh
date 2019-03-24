#!/usr/bin/env bash

docker container stop -t 0 nectar-vuejs-container
docker container rm nectar-vuejs-container

docker build -t nectar-vuejs . -f ./Dockerfile.staging
docker run --name nectar-vuejs-container -p 80:8080 -d nectar-vuejs
docker exec -it nectar-vuejs-container bash
