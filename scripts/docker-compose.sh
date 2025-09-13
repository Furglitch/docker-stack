#!/bin/bash

case "$1" in
    ""| "--start")
        printf "Starting Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Starting containers from compose: $dir \n"
                docker compose -f "$dir/docker-compose.yaml" up -d
            fi
        done
        ;;
    "--restart")
        printf "Restarting Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Restarting containers from compose: $dir \n"
                docker compose -f "$dir/docker-compose.yaml" restart
            fi
        done
        ;;
    "--stop")
        printf "Stopping Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Stopping containers from compose: $dir \n"
                docker compose -f "$dir/docker-compose.yaml" stop
            fi
        done
        ;;
    "--clear")
        printf "Stopping Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Stopping containers from compose: $dir \n"
                docker compose -f "$dir/docker-compose.yaml" stop
            fi
        done
        ;;
esac