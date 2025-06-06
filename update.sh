#!/bin/bash

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

echo "Selective update complete."