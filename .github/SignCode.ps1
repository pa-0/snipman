param(
   [Parameter(Mandatory=$true)]
   [string]$exe
)
$certPath = join-path (Split-Path $PSScriptRoot -Parent) '.github'
$csCertName = 'Abbasoft'
$timestampUrl = "http://timestamp.sectigo.com"
Write-Host "Signing the executable $exe"
&signtool sign /v /fd SHA256 /f "$certPath\$csCertName.pfx" /t $timestampUrl "$exe"
Write-Host "Verifying the signature..."
&signtool verify /pa "$exe" 
