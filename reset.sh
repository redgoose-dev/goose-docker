#!/usr/bin/env bash

docker-compose down
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

docker pull ubuntu:18.04