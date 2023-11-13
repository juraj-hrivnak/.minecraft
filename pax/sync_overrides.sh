#!/bin/bash

sync_directory() {
    source_dir="$1"
    dest_dir="modpack/overrides"

    if [ -d "$dest_dir/$source_dir" ]; then
        rm -rf "$dest_dir/$source_dir"
    fi

    cp -r "../$source_dir" "$dest_dir/$source_dir"

    echo "$source_dir synced!"
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
