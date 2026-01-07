#!/bin/bash

case "$1" in
    "")
        command=""
        ;;
    "--start"|"-s"|"start")
        phrase="Starting"
        command="up -d"
        ;;
    "--restart"|"-r"|"restart")
        phrase="Restarting"
        command="restart"
        ;;
    "--stop"|"-t"|"stop")
        phrase="Stopping"
        command="stop"
        ;;
    "--clear"|"-c"|"clear"|"--remove"|"-rm"|"-r"|"remove"|"--down"|"-d"|"down")
        phrase="Removing"
        command="down"
        ;;
esac

case "$2" in
    "")
        ;;
    "panel")
        compose="compose-panel/docker-compose.yaml"
        ;;
    "wings")
        compose="compose-wings/docker-compose.yaml"
        ;;
esac

if [ "$command" != "" ] && [ "$compose" != "" ]; then
    mkdir -p /home/user/docker/config
    printf "Executing 'docker compose %s'\n" "$command"
else
    printf "Usage:\n"
    printf "  setup.sh [action] [compose]\n\n"
    printf "  action: --start, --restart, --stop, --clear\n"
    printf "  compose: panel, wings\n"
fi


if [ "$command" != "" ] && [ "$compose" != "" ]; then
    printf "%s utility containers...\n" "$phrase"
    docker compose -f "/home/user/docker/compose-util/docker-compose.yaml" $command
    printf "%s %s containers...\n" "$phrase" "$2"
    docker compose -f "/home/user/docker/$compose" $command
fi