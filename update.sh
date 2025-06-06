#!/bin/bash

git fetch origin

DIFF_FILES=$(git diff --name-only HEAD..origin/main)

for FILE in $DIFF_FILES; do
    echo "Updating file: $FILE"
    git checkout origin/main -- "$FILE"
done

echo "Selective update complete."