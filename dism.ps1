$workingdir = Get-Location
$wimPath = Join-Path $workingdir "install.wim"
if (-not (Test-Path $wimPath)) {
    $wimPath = Join-Path $workingdir "install.esd"
}


DISM /Get-WimInfo /WimFile:"$wimPath"

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

$mountPath = Join-Path $workingdir "mount"
DISM /Mount-Wim /WimFile:"$wimPath" /index:$selectedNumber /MountDir:"$mountPath"