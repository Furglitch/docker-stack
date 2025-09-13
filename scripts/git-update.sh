#!/bin/bash

if [ "$USER" != "root" ]; then
    printf "This script must be run as root. Please use sudo.\nExiting."
    exit 1
fi

printf 'Remember to review any changes to configuration files in the "config" directory and the .env file in "docker-compose".\n'
printf 'Currently known files that may need adjustments:\n'
printf ' - /docker-compose/.env (IPs, Domain, Secrets)\n'
printf ' - /config/homepage/services.yaml (Ports, API Keys, Passkeys)\n'
printf ' - /config/kometa/config.yml (Ports, API Keys)\n\n'
printf '\n\n'
printf 'Press [ENTER] to continue with the update or [CTRL+C] to cancel...'
read -r

git fetch origin

DIFF_FILES=$(git diff --name-only HEAD..origin/main)

for FILE in $DIFF_FILES; do
    echo "Updating file: $FILE"
    git checkout origin/main -- "$FILE"
done

# Updates the .git directory to match the remote repository
git clone --no-checkout "$(git config --get remote.origin.url)" "./.temp"
chmod 0700 "./.temp/.git"
rm -rf "./.git"
mv "./.temp/.git" ./
rm -rf "./.temp"

cp -r ./config /docker/config

echo "Selective update complete."