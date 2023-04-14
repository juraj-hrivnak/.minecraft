#!/bin/bash

depth=1

git checkout main
mods_removed=$(git diff -U0 {main~${depth},main}:pax/modpack/manifest.json | grep '^-' | grep -P -o '"files":.*\[\K[^\]]*' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /')
mods_added=$(git diff -U0 {main~${depth},main}:pax/modpack/manifest.json | grep '^+' | grep -P -o '"files":.*\[\K[^\]]*' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /')

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "x---------------x"
echo "|  Mod Changes  |"
[ ! -z "$mods_removed" ] && echo -e "${RED}Removed: \n$mods_removed${NC}"
[ ! -z "$mods_added" ] && echo -e "${GREEN}Added: \n$mods_added${NC}"
echo "x---------------x"

# Wait for user response
read -p "Done! Press any key to continue" x
