#!/bin/bash

# Parse json
pax_version=$(grep -Po '(?<="PAX": ")[^"]*' setup.json)
server_pack_creator_version=$(grep -Po '(?<="ServerPackCreator": ")[^"]*' setup.json)

echo "pax_version value is: $pax_version"
echo "server_pack_creator_version value is: $server_pack_creator_version"

# Download pax
curl https://github.com/froehlichA/pax/releases/download/v$pax_version/pax -o pax -L -J

# Download server pack creator
curl https://github.com/Griefed/ServerPackCreator/releases/download/$server_pack_creator_version/ServerPackCreator-$server_pack_creator_version.jar -o ./serverpack/ServerPackCreator-$server_pack_creator_version.jar -L -J

# Wait for user response
read -p "Press any key to continue" x
