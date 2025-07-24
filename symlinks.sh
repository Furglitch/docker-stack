#!/bin/bash

for dir in docker-compose/*; do
    ln -s ../.env $dir/.env
done;