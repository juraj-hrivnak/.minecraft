echo Started to syncing files!

# config
cd modpack/overrides
if [ ! -d "/config" ]
then
    mkdir config
fi
cd config
if [ -d "../config" ]
then
    rm -r *
fi
echo removing files
cd ../../../..
cp -r config pax/modpack/overrides/
cd pax

# # resources
# cd modpack/overrides
# if not exist "resources" mkdir "resources"
# cd resources
# rm -r /*
# cd ../../../..
# xcopy -r resources pax/modpack/overrides/resources/
# cd pax

# # scripts
# cd modpack/overrides
# if not exist "scripts" mkdir "scripts"
# cd scripts
# rm -r /*
# cd ../../../..
# xcopy -r scripts pax/modpack/overrides-rcripts/
# cd pax

read -p "Done!"
