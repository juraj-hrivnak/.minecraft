echo Started to syncing files!

rem config
cd modpack\overrides
if not exist "config" mkdir "config"
cd config
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
cd ..\..\..\..
xcopy /s config pax\modpack\overrides\config\
cd pax

@REM rem resourcepacks
@REM cd modpack\overrides
@REM if not exist "resourcepacks" mkdir "resourcepacks"
@REM cd resourcepacks
@REM for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
@REM cd ..\..\..\..
@REM xcopy /s resourcepacks pax\modpack\overrides\resourcepacks\
@REM cd pax

rem resources
cd modpack\overrides
if not exist "resources" mkdir "resources"
cd resources
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
cd ..\..\..\..
xcopy /s resources pax\modpack\overrides\resources\
cd pax

rem scripts
cd modpack\overrides
if not exist "scripts" mkdir "scripts"
cd scripts
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
cd ..\..\..\..
xcopy /s scripts pax\modpack\overrides\scripts\
cd pax

echo Done!
