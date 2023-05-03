#!/bin/bash

cd ../
manifest="./pax/modpack/manifest.json"
changelog="./CHANGELOG.md"

branch=$(git rev-parse --abbrev-ref HEAD)
previous_commit=$(git log -n 1 --skip 1 --pretty=format:"%h" -- $manifest)
latest_commit=$(git log -n 1 --pretty=format:"%h" $branch -- $manifest)
latest_tag=$(git describe --tags --abbrev=0)
latest_tagged_commit=$(git rev-list -n 1 --pretty=format:"%h" $latest_tag | sed -n 2p)

if [ $latest_tagged_commit = $latest_commit ]; then
    latest_tag=$(git describe --tags --abbrev=0 $(git describe --tags --abbrev=0)^)
    latest_tagged_commit=$(git rev-list -n 1 --pretty=format:"%h" $latest_tag | sed -n 2p)
fi

echo "branch: $branch"
echo "previous commit: $previous_commit"
echo "latest commit: $latest_commit"
echo "latest tagged commit: $latest_tagged_commit"
echo "latest tag: $latest_tag"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
NC='\033[0m'

function mod_changes {
    local mods_added_var1=$(git diff -W $latest_tagged_commit $latest_commit -- $manifest)
    local mods_added_var2=$(echo "$mods_added_var1" | ggrep -P -o -z '"files":[\s]*\K\[((?!.)[\s\S]*\])*' | tr -d '\0')
    local mods_added_var3=$(echo "$mods_added_var2" | ggrep '^+' | ggrep -P -o '"name":[\s]*"\K[^"]*')

    local mods_removed_var1=$(git diff -W $latest_tagged_commit $latest_commit -- $manifest)
    local mods_removed_var2=$(echo "$mods_removed_var1" | ggrep -P -o -z '"files":[\s]*\K\[((?!.)[\s\S]*\])*' | tr -d '\0')
    local mods_removed_var3=$(echo "$mods_removed_var2" | ggrep '^-' | ggrep -P -o '"name":[\s]*"\K[^"]*')

    if [[ ! -z ""$mods_added_var3"" ]] || [[ ! -z ""$mods_removed_var3"" ]]; then
        echo "x---------------x"
        echo "|  Mod Changes  |"

        echo "\n## Mod Changes\n" >> $changelog
        echo "Since: \`$latest_tag\`\n" >> $changelog
        echo '```markdown' >> $changelog
    fi

    if [[ ! -z ""$mods_added_var3"" ]]; then
        echo "${GREEN}Added:"
        echo "Added:" >> $changelog
        while IFS= read -r line1; do
            local foo=""
            while IFS= read -r line2; do
                foo="${line1//$line2}"
                if [[ -z ""$foo"" ]]; then
                    break
                fi
            done <<< "$mods_removed_var3"
            if [[ ! -z ""$foo"" ]]; then
                echo "- $foo"
                echo "- $foo" >> $changelog
            fi
        done <<< "$mods_added_var3"
    fi

    if [[ ! -z ""$mods_removed_var3"" ]]; then
        echo "${RED}Removed:"
        echo "Removed:" >> $changelog
        while IFS= read -r line1; do
            local foo=""
            while IFS= read -r line2; do
                foo="${line1//$line2}"
                if [[ -z ""$foo"" ]]; then
                    break
                fi
            done <<< "$mods_added_var3"
            if [[ ! -z ""$foo"" ]]; then
                echo "- $foo"
                echo "- $foo" >> $changelog
            fi
        done <<< "$mods_removed_var3"
    fi

    if [[ ! -z ""$mods_added_var3"" ]] || [[ ! -z ""$mods_removed_var3"" ]]; then
        echo "${NC}x---------------x"

        echo '```' >> $changelog
    fi
}

# | grep -P -o '"files":[\s]*\[\K[^\]]*'
# | grep -P -o '((?<!"files".)[\s\S])*$'
# | grep -P -o '((?<!"files"(.|\s)(.|\s))[\s\S])*\]'
# ((?<!"files"(.|\s)(.|\s))[\s\S])*\]*"name":[\s]*"\K[^"]*.*
# ((?<="files"(.|\s)(.|\s))[\s\S])*
# (?<="files"(.|\s)(.|\s).)[\s\S]*\]
# "files":[\s]*\[\K((?!.)[\s\S]*\}[\s]*\])*

mod_changes
