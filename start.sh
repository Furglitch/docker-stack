#!/bin/bash

sudo mkdir -p /docker
sudo chown -R $USER:$USER /docker
sudo chmod -R 755 /docker
cp -r ./config /docker/config

./scripts/docker-compose.sh --start