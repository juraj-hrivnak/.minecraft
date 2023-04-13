#!/bin/bash

pax_version=$(grep -Po '(?<="PAX": ")[^"]*' setup.json)
server_pack_creator_version=$(grep -Po '(?<="ServerPackCreator": ")[^"]*' setup.json)
echo "pax_version value is: $pax_version"
echo "server_pack_creator_version value is: $server_pack_creator_version"

# curl https://github.com/froehlichA/pax/releases/download/v$pax_version/pax-windows.zip -o pax.zip -L -J
curl https://github.com/froehlichA/pax/releases/download/v$pax_version/pax -o pax -L -J

curl https://github.com/Griefed/ServerPackCreator/releases/download/$server_pack_creator_version/ServerPackCreator-$server_pack_creator_version.jar -o ./serverpack/ServerPackCreator-$server_pack_creator_version.jar -L -J

# unzip pax.zip -d '.\'
# rm pax.zip

read -p "Press any key to continue" x
