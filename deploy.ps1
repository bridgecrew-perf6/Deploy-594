$properties=Get-Content deploy-properties.json | ConvertFrom-Json

For($i=1;$i -le $properties.apps.Length;$i++) 
{ 
   Write-Output "$i. $($properties.apps[$i-1].name)"
}
$app=""
Do {
	$app = Read-Host "Which project do you want to build with Cordova ?"
} Until ($app -eq 1 -or $app -le $properties.apps.Length)

$app=$properties.apps[$app-1]
Write-Host "Deploying $app" -ForegroundColor Cyan

$dir = Get-Location
Set-Variable -Name "workspace" -Value ((Split-Path ($dir | Select-Object -ExpandProperty Path) -Parent) + "\" + $app.name)
if (-not (Test-Path -Path $properties.outputDir)) {
	Write-Host "Output Directory"$properties.outputDir"doesn't exist" -ForegroundColor Red
	exit
}
Write-Host "Generating apk file" -ForegroundColor Cyan
& ".\cordova.ps1" -name $app.name -outputDir $properties.outputDir -workspace $workspace -java $properties.java_path -size $app.size
& ".\replace.ps1" -file ($workspace + "\dist\index.html") -searched "file:///android_asset/www/" -value '/'

cd $dir
pause
