
$json = Get-Content '.\setup.json' | Out-String | ConvertFrom-Json
$PAXVersion = $json.PAX
$ServerPackCreatorVersion = $json.ServerPackCreator

Invoke-WebRequest https://github.com/froehlichA/pax/releases/download/v$PAXVersion/pax-windows.zip -OutFile pax.zip
Expand-Archive -Path pax.zip -DestinationPath .\
Remove-Item pax.zip

Invoke-WebRequest https://github.com/Griefed/ServerPackCreator/releases/download/$ServerPackCreatorVersion/ServerPackCreator-$ServerPackCreatorVersion.jar -OutFile ./serverpack/ServerPackCreator-$ServerPackCreatorVersion.jar
