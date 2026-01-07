#!/bin/bash

case "$1" in
    "")
        command=""
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

if [ "$command" != "" ]; then
    printf "Executing 'docker compose %s'\n" "$command"
else
    printf "Usage:\n"
    printf "  setup.sh [action]\n\n"
    printf "  action: --start, --restart, --stop, --clear\n"
fi


mkdir -p /home/user/docker/config
printf "Setting up panel containers...\n"
docker compose -f "compose-panel/docker-compose.yaml" $command
printf "Setting up wings containers...\n"
docker compose -f "compose-wings/docker-compose.yaml" $command
printf "Setting up utility containers...\n"
docker compose -f "compose-util/docker-compose.yaml" $command