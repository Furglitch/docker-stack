#!/bin/bash

if [ "$1" != "" ] && [ "$2" != "" ]; then
    sudo mkdir -p /home/user/docker/config
    cp -r ./config /home/user/docker
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
    "media"| "web"| "all")
        mkdir -p /home/user/docker/config
        #cp -r ./config-util/* /home/user/docker/config
        printf "Setting up utility containers...\n"
        docker compose -f "compose-util/docker-compose.yaml" $command
        ;;
esac

case "$2" in
    "")
        ;;
    "media")
        cp -r ./config-media/* /home/user/docker/config
        printf "Setting up media containers...\n"
        docker compose -f "compose-media/docker-compose.yaml" $command
        ;;
    "web")
        cp -r ./config-web/* /home/user/docker/config
        printf "Setting up web containers...\n"
        docker compose -f "compose-web/docker-compose.yaml" $command
        ;;
    "all")
        cp -r ./config-media/* /home/user/docker/config
        cp -r ./config-web/* /home/user/docker/config
        printf "Setting up media containers...\n"
        docker compose -f "compose-media/docker-compose.yaml" $command
        printf "Setting up web containers...\n"
        docker compose -f "compose-web/docker-compose.yaml" $command
        ;;
esac