#!/bin/bash

git checkout main
commit=$(git log --skip 2 --pretty=format:"%h" -n 1 --follow modpack/manifest.json)

mods_removed=$(git diff -U0 {${commit},main}:pax/modpack/manifest.json | grep '^-')
mods_added=$(git diff -U0 {${commit},main}:pax/modpack/manifest.json | grep '^+')


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "x---------------x"
echo -e "|  Mod Changes  |"
if [ ! -z "$mods_removed" ]; then
    echo -e "${RED}Removed:"
    echo -e $mods_removed | grep -P -o '"files":[\s]*\[\K[^\]]*' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
fi
if [ ! -z "$mods_added" ]; then
    echo -e "${GREEN}Added:"
    echo -e $mods_added | grep -P -o '"files":[\s]*\[\K[^\]]*' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
fi
echo -e "${NC}x---------------x"

# Wait for user response
read -p "Done! Press any key to continue" x
