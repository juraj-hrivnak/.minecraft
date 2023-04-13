#!/bin/bash

git checkout main
mod=$(git diff --diff-filter=ad {main~1,main}:pax/modpack/manifest.json | grep -Po '(?<="name": ")[^"]*')

echo "$mod"

git diff --summary {main~1,main}:pax/modpack/manifest.json

# mod=$($diffo )

# Wait for user response
read -p "Done! Press any key to continue" x
