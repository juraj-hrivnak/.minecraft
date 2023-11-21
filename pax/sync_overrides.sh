#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'

sync_directory() {
    source_dir="$1"
    dest_dir="modpack/overrides"

    if [ -d "$dest_dir/$source_dir" ]; then
        rm -rf "$dest_dir/$source_dir"
    fi

    if [ -d "../$source_dir" ]; then
        cp -r "../$source_dir" "$dest_dir/$source_dir"
        echo -e "${GREEN}$source_dir synced"
    else
        echo -e "${RED}$source_dir not found"
    fi
}

echo "Started syncing files!"

# Sync each directory
sync_directory "config"
sync_directory "local"
sync_directory "oresources"
sync_directory "patchouli_books"
sync_directory "resources"
sync_directory "scripts"
sync_directory "structures"

echo "Syncing completed!"
