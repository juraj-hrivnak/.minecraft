
cd ..
if not exist "mods" mkdir "mods"
cd mods
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
cd ..\pax\modpack\overrides
xcopy /s mods ..\..\..\mods
cd ..\..

cmd /c java -jar ModpackDownloader-cli-0.6.1.jar -manifest modpack/manifest.json -folder ../mods

echo Done!
