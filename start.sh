#!/bin/bash

if [ "$USER" != "root" ]; then
    printf "This script must be run as root. Please use sudo.\nExiting."
    exit 1
fi

case "$1" in
    ""| "--start")
        printf "Starting Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                docker-compose -f "$dir/docker-compose.yaml" up -d
            fi
        done
        ;;
    "--restart")
        printf "Restarting Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                docker-compose -f "$dir/docker-compose.yaml" restart
            fi
        done
        ;;
    "--stop")
        printf "Stopping Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                docker-compose -f "$dir/docker-compose.yaml" down
            fi
        done
        ;;
esac

printf "\nEnd of script.\nExiting."