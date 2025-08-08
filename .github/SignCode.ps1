param(
   [Parameter(Mandatory=$true)]
   [string]$exe
)
$certPath = $PSScriptRoot
$csCertName = 'Abbasoft'
$timestampUrl = "http://timestamp.sectigo.com"
Write-Host "Signing the executable $exe"
&signtool sign /v /fd SHA256 /f "$certPath\$csCertName.pfx" /t $timestampUrl "$exe"
Write-Host "Verifying the signature..."
&signtool verify /pa "$exe"
Read-Host "Press a key to continue..."