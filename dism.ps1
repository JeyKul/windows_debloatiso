$workingdir = Get-Location
$wimPath = Join-Path $workingdir "install.wim"
$esdPath = Join-Path $workingdir "install.esd"

# Check if install.esd exists
if (Test-Path $esdPath -PathType Leaf) {
    Write-Host "install.esd found. Getting image info..."
    dism /Get-WimInfo /WimFile:$esdPath
} else {
    Write-Host "install.esd not found. Getting image info from install.wim..."
    dism /Get-WimInfo /WimFile:$wimPath
}

$isValidInput = $false
while (-not $isValidInput) {
    $userInput = Read-Host "Enter a number:"
    if ($userInput -match '^\d+$') {
        $isValidInput = $true
    } else {
        Write-Host "Invalid input. Please enter a valid number."
    }
}
$selectedNumber = [int]$userInput
Write-Host "You entered: $selectedNumber"

if (Test-Path $esdPath -PathType Leaf) {
    Write-Host "install.esd found. Exporting image..."
    dism /export-image /SourceImageFile:$esdPath /SourceIndex:2 /DestinationImageFile:$wimPath /Compress:max /CheckIntegrity
} else {
    Write-Host "install.esd not found. Continuing with the script..."
}

$mountPath = Join-Path $workingdir "mount"
DISM /Mount-Wim /WimFile:"$wimPath" /index:1 /MountDir:"$mountPath"