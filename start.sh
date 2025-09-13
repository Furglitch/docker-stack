#!/bin/bash

sudo mkdir -p /home/user/.docker/config
cp -r ./config /home/user/.docker/config

./scripts/docker-compose.sh --start