#!/bin/bash

for dir in compose-panel compose-wings compose-util; do
    if [ -d "$dir" ]; then
        rm -f "$dir/.env"
        ln -s "../.env" "$dir/.env"
    fi
done