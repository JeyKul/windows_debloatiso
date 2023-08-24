$workingdir = Get-Location
$wimPath = Join-Path $workingdir "install.wim"
$esdPath = Join-Path $workingdir "install.esd"

$mountPath = Join-Path $workingdir "mount"
DISM /Mount-Wim /WimFile:"$wimPath" /index:1 /MountDir:"$mountPath"