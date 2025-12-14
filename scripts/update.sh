#!/bin/bash

if [ "$USER" != "root" ]; then
    printf "This script must be run as root. Please use sudo.\nExiting."
    exit 1
fi

printf "This script will pull updates from the remote repository and update only the changed files.\n"
printf 'Remember to review any changes to configuration files and the .env file.\n\n'
printf 'Press [ENTER] to continue with the update or [CTRL+C] to cancel...'
read -r

# Pull changed files from remote repository
git fetch origin
DIFF_FILES=$(git diff --name-only HEAD..origin/main)
for FILE in $DIFF_FILES; do
    echo "Updating file: $FILE"
    git checkout origin/main -- "$FILE"
done
git clone --no-checkout "$(git config --get remote.origin.url)" "./.temp"
if [ -d ./.temp/.git ]; then
    rm -rf "./.git"
    mv "./.temp/.git" ./
fi

if [ -d ./.temp ]; then
    # Find files (relative paths) present in both current dir and ./.temp
    DIFF_FILES=$(comm -12 \
        <(find . -type f -not -path './.git/*' -printf '%P\n' | sort) \
        <(find ./.temp -type f -printf '%P\n' | sort))
else
    DIFF_FILES=""
fi

# For files that exist in both places, rename the local file to .bk before copying
for FILE in $DIFF_FILES; do
    if [ -f "$FILE" ]; then
        printf "Backing up existing file: $FILE to $FILE.bk\n"
        mv "$FILE" "$FILE.bk"
    fi
done

for FILE in $(find ./.temp -type f -printf '%P\n' | sort); do
    printf "Copying file: $FILE\n"
    cp ./.temp/"$FILE" "$FILE"
done

rm -rf "./.temp"

printf "\n"
printf "Update process finished. Please review any .bk files for changes to configuration or important data.\n"
printf "Known files that may require manual merging:\n"
printf " - .env\n"
printf " - config-media/recyclarr/recyclarr.yml\n"
printf " - config-web/homepage/services.yaml\n"
printf " - config-web/mediawiki/LocalSettings.php\n"