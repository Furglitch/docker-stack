#!/bin/bash

if [ "$USER" != "root" ]; then
    printf "This script must be run as root. Please use sudo.\nExiting."
    exit 1
fi

printf "This script will pull updates from the remote repository and update only the changed files.\n"
printf 'Remember to review the README for the list of potential changes.\n'
printf 'Backups will be attempted, but no guarantees can be made\n\n'
printf 'Press [ENTER] to continue with the update or [CTRL+C] to cancel...'
read -r

rm -rf ./.temp
mkdir -p ./.temp
git fetch origin
git archive origin/docker | tar -x -C ./.temp

if [ -d ./.temp ]; then
    echo "Determining changed files between HEAD and origin/docker..."
    DIFF_FILES=$(git diff --name-only HEAD..origin/docker)
else
    DIFF_FILES=""
fi

echo "Files to be updated:"
echo "$DIFF_FILES"

if [ -n "$DIFF_FILES" ]; then
    while IFS= read -r FILE; do
        [ -z "$FILE" ] && continue
        if [ -f "$FILE" ]; then
            echo "Backup created: $FILE.bk"
            mv -- "$FILE" "$FILE.bk"
        fi
        mkdir -p "$(dirname "$FILE")"
        cp -- ./.temp/"$FILE" "$FILE"
    done <<< "$DIFF_FILES"
fi

rm -rf "./.temp"

WATCHED_FILES=(
    ".env"
    "compose-web/docker-compose.yaml"
    "config-media/recyclarr/recyclarr.yml"
    "config-web/homepage/services.yaml"
    "config-media/kometa/config.yml"
)

OVERWRITTEN_LIST=""
for f in "${WATCHED_FILES[@]}"; do
    if [ -f "$f.bk" ]; then
        OVERWRITTEN_LIST="$OVERWRITTEN_LIST\n - $f"
    fi
done

if [ -n "$OVERWRITTEN_LIST" ]; then
    printf "\nWARNING: The following config files were updated by the pull and may have overridden local settings:\n"
    printf "%b\n" "$OVERWRITTEN_LIST"
    printf "\nThe pre-pull versions were saved alongside them with a .bk extension (e.g. %s.bk).\n" "<file>"
    printf "Please review and merge any required settings from the .bk files back into the updated files.\n"
    printf "Delete the .bk files once you have confirmed that all necessary settings have been restored to avoid confusion in the future.\n"
fi