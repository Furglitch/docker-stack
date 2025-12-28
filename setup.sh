#!/bin/bash

if [ "$1" != "" ] && [ "$2" != "" ]; then
    printf "Executing action: %s on compose: %s\n" "$1" "$2"
else
    printf "Usage:\n"
    printf "  setup.sh [action] [compose]\n\n"
    printf "  action: --start, --restart, --stop, --clear\n"
    printf "  compose: media, web, all\n"
fi

case "$1" in
    "")
        ;;
    "--start")
        command="up -d"
        ;;
    "--restart")
        command="restart"
        ;;
    "--stop")
        command="stop"
        ;;
    "--clear")
        command="down"
        ;;
esac

case "$2" in
    "")
        ;;
    "media"| "web"| "util"| "all")
        mkdir -p /home/user/docker/config
        printf "Setting up utility containers...\n"
        docker compose -f "compose-util/docker-compose.yaml" $command
        ;;
esac

case "$2" in
    "")
        ;;
    "media")
        printf "Setting up media containers...\n"
        docker compose -f "compose-media/docker-compose.yaml" $command
        ;;
    "web")
        printf "Setting up web containers...\n"
        docker compose -f "compose-web/docker-compose.yaml" $command
        ;;
    "util")
        printf "Setting up util containers...\n"
        docker compose -f "compose-util/docker-compose.yaml" $command
        ;;
    "all")
        printf "Setting up media containers...\n"
        docker compose -f "compose-media/docker-compose.yaml" $command
        printf "Setting up web containers...\n"
        docker compose -f "compose-web/docker-compose.yaml" $command
        ;;
esac