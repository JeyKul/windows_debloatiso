$workingdir = Get-Location
$isoFileName = "windows.iso"
$isoFilePath = Join-Path $workingdir $isoFileName
$extractPath = Join-Path $workingdir "extracted_files"
$isoCopyPath = Join-Path $workingdir "iso"

# Check if the "iso" directory is empty
$isoDirectoryIsEmpty = @(Get-ChildItem -Path $isoCopyPath).Count -eq 0

# If the "iso" directory is not empty, prompt the user to delete its contents
if (-not $isoDirectoryIsEmpty) {
    Write-Host "The 'iso' directory already contains files."
    $userInput = Read-Host "Do you want to delete its contents? (Y/N)"
    
    if ($userInput -eq "Y" -or $userInput -eq "y") {
        Remove-Item -Path $isoCopyPath\* -Force -Recurse
        Write-Host "Contents of the 'iso' directory deleted."
    } else {
        Write-Host "Aborted."
        Exit
    }
}

# Mount the ISO file
$mountedDrive = Mount-DiskImage -ImagePath $isoFilePath -PassThru
$driveLetter = ($mountedDrive | Get-Volume).DriveLetter

# Copy the contents of the mounted ISO to the "iso" directory
Copy-Item -Path "$driveLetter`:\*" -Destination $isoCopyPath -Recurse -Force

# Dismount the ISO
Dismount-DiskImage -ImagePath $isoFilePath

Write-Host "Contents of the mounted ISO copied to the 'iso' directory in the working directory."

copy .\iso\sources\install.wim .\install.wim
copy .\iso\sources\install.esd .\install.esd