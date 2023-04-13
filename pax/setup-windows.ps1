
# Parse json
$json = Get-Content '.\setup.json' | Out-String | ConvertFrom-Json
$pax_version = $json.PAX
$server_pack_creator_version = $json.ServerPackCreator

Write-Output "pax_version value is: $pax_version"
Write-Output "server_pack_creator_version value is: $server_pack_creator_version"

# Download and unzip pax
Invoke-WebRequest https://github.com/froehlichA/pax/releases/download/v$pax_version/pax-windows.zip -OutFile pax.zip
Expand-Archive -Path pax.zip -DestinationPath .\
Remove-Item pax.zip

# Download server pack creator
Invoke-WebRequest https://github.com/Griefed/ServerPackCreator/releases/download/$server_pack_creator_version/ServerPackCreator-$server_pack_creator_version.jar -OutFile ./serverpack/ServerPackCreator-$server_pack_creator_version.jar

# Wait for user response
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
