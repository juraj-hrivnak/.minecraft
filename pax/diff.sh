#!/bin/bash

commit=$(git log -n 1 --skip 2 --pretty=format:"%h" -- pax/modpack/manifest.json)
latest_commit=$(git log -n 1 --skip 2 --pretty=format:"%h" origin/main)

echo $commit
echo $latest_commit

mods_added=$(git diff -U0 $commit $latest_commit -- pax/modpack/manifest.json | grep '^+')
mods_removed=$(git diff -U0 $commit $latest_commit -- pax/modpack/manifest.json | grep '^-')

git diff -U0 $commit $latest_commit -- pax/modpack/manifest.json

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# | grep -P -o '"files":[\s]*\[\K[^\]]*'
# | grep -P -o '"files":[\s]*\[\K[^\]]*'

echo -e "x---------------x"
echo -e "|  Mod Changes  |"
echo -e "${GREEN}Added:"
echo -e $mods_added | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
echo -e "${RED}Removed:"
echo -e $mods_removed | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
echo -e "${NC}x---------------x"

# Wait for user response
read -p "Done! Press any key to continue" x
