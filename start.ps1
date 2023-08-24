$colorRed = [char]27 + '[31m'
$colorGreen = [char]27 + '[32m'
$colorYellow = [char]27 + '[33m'
$colorBlue = [char]27 + '[34m'
$colorReset = [char]27 + '[0m'

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $arguments = "& `"$originalScriptPath`""
    Start-Process powershell -Verb RunAs -ArgumentList $arguments
    Exit
}

if (-not (Test-Path .\iso)) {
    New-Item -ItemType Directory -Path .\iso | Out-Null
}
if (-not (Test-Path .\mount)) {
    New-Item -ItemType Directory -Path .\mount | Out-Null
}
if (-not (Test-Path .\drivers)) {
    New-Item -ItemType Directory -Path .\drivers | Out-Null
}
if (-not (Test-Path .\updates)) {
    New-Item -ItemType Directory -Path .\updates | Out-Null
}

Write-Host ($colorGreen + "hi!")
Write-Host ($colorGreen + "This is a tool, which helps modifying windows installation files.")
Write-Host " "
Write-Host ($colorRed + "Press any key to continue...")
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ($colorGreen + "This tool created folders, which give you the power of customization.")
Write-Host ($colorGreen + "The folder " + $colorBlue + "drivers" + $colorGreen + " is for your own custom drivers. You should make folders inside, so everything is nice and sorted.")
Write-Host ($colorGreen + "Including to that we try to update your Windows.")
Write-Host ($colorGreen + "If you have Files you want to add to the " + $colorRed + "hopefully" + $colorGreen + " automatic update process, add them to the " + $colorBlue + "updates" + $colorGreen + " folder.")
Write-Host ($colorGreen + "These files are usually .cap or .msu files.")
Write-Host ($colorGreen + "Download the latest cumulative update from here: " + $colorBlue + "https://www.catalog.update.microsoft.com/Search.aspx?q=cumulative")
Write-Host " "
Write-Host ($colorRed + "Press any key to continue...")
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ($colorGreen + "That's everything so far. I hope you enjoy this!")

Start-Process powershell -Verb RunAs -ArgumentList "-File copy_files.ps1" -Wait
Write-Host "copy_files.ps1 script has finished. Continuing..."
Write-Host "now we're going to mount and modify your windows!"
Start-Process powershell -Verb RunAs -ArgumentList "-File dism.ps1" -Wait
Start-Process powershell -Verb RunAs -ArgumentList "-File debloat.ps1" -Wait