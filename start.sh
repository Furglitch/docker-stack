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
                printf "Starting containers from compose: $dir"
                docker-compose -f "$dir/docker-compose.yaml" up -d
            fi
        done
        ;;
    "--restart")
        printf "Restarting Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Restarting containers from compose: $dir"
                docker-compose -f "$dir/docker-compose.yaml" restart
            fi
        done
        ;;
    "--stop")
        printf "Stopping Docker containers...\n"
        for dir in docker-compose/*; do
            if [ -d "$dir" ]; then
                printf "Stopping containers from compose: $dir"
                docker-compose -f "$dir/docker-compose.yaml" down
            fi
        done
        ;;
esac

for folder in /mnt/share/*; do
    chown 1000:1000 "$folder"
done

printf "\nEnd of script.\nExiting."