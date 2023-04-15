#!/bin/bash

cd ../
manifest="pax/modpack/manifest.json"

branch=$(git rev-parse --abbrev-ref HEAD)
previous_commit=$(git log -n 1 --skip 1 --pretty=format:"%h" -- $manifest)
latest_commit=$(git log -n 1 --pretty=format:"%h" $branch -- $manifest)

echo "branch: $branch"
echo "previous commit: $previous_commit"
echo "latest commit: $latest_commit"

mods_added=$(git diff -U0 $previous_commit $latest_commit -- $manifest | grep '^+')
mods_removed=$(git diff -U0 $previous_commit $latest_commit -- $manifest | grep '^-')

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# | grep -P -o '"files":[\s]*\[\K[^\]]*.*'
# | grep -P -o '((?<!"files".)[\s\S])*$'
# | grep -P -o '((?<!"files"(.|\s)(.|\s))[\s\S])*\]'
# ((?<!"files"(.|\s)(.|\s))[\s\S])*\]*"name":[\s]*"\K[^"]*.*
# ((?<="files"(.|\s)(.|\s))[\s\S])*
# (?<="files"(.|\s)(.|\s).)[\s\S]*\]

echo -e "x---------------x"
echo -e "|  Mod Changes  |"
echo -e "${GREEN}Added:"
echo -e $mods_added | grep -P -o '(?<="files"(.|\s)(.|\s).)[\s\S]*\]' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
echo -e "${RED}Removed:"
echo -e $mods_removed | grep -P -o '(?<="files"(.|\s)(.|\s).)[\s\S]*\]' | grep -P -o '"name":[\s]*"\K[^"]*' | sed -e 's/^/- /'
echo -e "${NC}x---------------x"

# Wait for user response
read -p "Done! Press any key to continue" x
