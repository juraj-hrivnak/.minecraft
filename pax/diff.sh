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

git show $latest_tagged_commit:$manifest > ./pax/modpack/manifest_prev.json
mods_removed_raw=$(./pax/jd -set ./pax/modpack/manifest_prev.json $manifest | grep '^-' | grep -P -o '"name":[\s]*"\K[^"]*' | tr -d '\[\]')
mods_added_raw=$(./pax/jd -set ./pax/modpack/manifest_prev.json $manifest | grep '^+' | grep -P -o '"name":[\s]*"\K[^"]*' | tr -d '\[\]')

mods_added=""
mods_removed=""
mods_updated=""

mod_changes=""

if [[ ! -z ""$mods_added_raw"" ]]; then
    while IFS= read -r line1; do
        foo=""
        while IFS= read -r line2; do
            foo="${line1//$line2}"
            if [[ -z ""$foo"" ]]; then
                if [[ ! -z ""$mods_updated"" ]]; then
                    mods_updated+="\n"
                fi
                mods_updated+="- $line1"
                break
            fi
        done <<< "$mods_removed_raw"
        if [[ ! -z ""$foo"" ]]; then
            if [[ ! -z ""$mods_added"" ]]; then
                mods_added+="\n"
            fi
            mods_added+="- $foo"
        fi
    done <<< "$mods_added_raw"
fi

if [[ ! -z ""$mods_removed_raw"" ]]; then
    while IFS= read -r line1; do
        bar=""
        while IFS= read -r line2; do
            bar="${line1//$line2}"
            if [[ -z ""$bar"" ]]; then
                break
            fi
        done <<< "$mods_added_raw"
        if [[ ! -z ""$bar"" ]]; then
            if [[ ! -z ""$mods_removed"" ]]; then
                mods_removed+="\n"
            fi
            mods_removed+="- $bar"
        fi
    done <<< "$mods_removed_raw"
fi

if [[ ! -z ""$mods_added"" ]] || [[ ! -z ""$mods_removed"" ]] || [[ ! -z ""$mods_updated"" ]]; then
    echo -e "x---------------x"
    echo -e "|  Mod Changes  |"

    echo '## Mod Changes' >> $GITHUB_STEP_SUMMARY
    echo "Since: \`$latest_tag\`" >> $GITHUB_STEP_SUMMARY
    echo '```markdown' >> $GITHUB_STEP_SUMMARY

    mod_changes+="## Mod Changes\n\n"
    mod_changes+="Since: \`$latest_tag\`\n\n"
    mod_changes+="\`\`\`markdown\n"
fi

if [[ ! -z ""$mods_added"" ]]; then
    echo -e "${GREEN}Added:"
    echo -e "$mods_added"

    echo "Added:" >> $GITHUB_STEP_SUMMARY
    echo -e "$mods_added" >> $GITHUB_STEP_SUMMARY

    mod_changes+="Added:\n"
    mod_changes+="$mods_added\n"
fi
if [[ ! -z ""$mods_removed"" ]]; then
    echo -e "${RED}Removed:"
    echo -e "$mods_removed"

    echo "Removed:" >> $GITHUB_STEP_SUMMARY
    echo -e "$mods_removed" >> $GITHUB_STEP_SUMMARY

    mod_changes+="Removed:\n"
    mod_changes+="$mods_removed\n"
fi
if [[ ! -z ""$mods_updated"" ]]; then
    echo -e "${BLUE}Updated:"
    echo -e "$mods_updated"

    echo "Updated:" >> $GITHUB_STEP_SUMMARY
    echo -e "$mods_updated" >> $GITHUB_STEP_SUMMARY

    mod_changes+="Updated:\n"
    mod_changes+="$mods_updated\n"
fi

if [[ ! -z ""$mods_added"" ]] || [[ ! -z ""$mods_removed"" ]] || [[ ! -z ""$mods_updated"" ]]; then
    echo -e "${NC}x---------------x"

    echo '```' >> $GITHUB_STEP_SUMMARY

    mod_changes+="\`\`\`"
fi

perl -i -pe "s/\@mod_changes\@/$mod_changes/g" $changelog

rm ./pax/modpack/manifest_prev.json
