#!/bin/bash

sudo mkdir -p /home/user/.docker/config
cp -r ./config /home/user/.docker

./scripts/docker-compose.sh --start