# PowerShell 
$sourceFolder = "C:\Program Files (x86)\Steam\userdata\useridhere\1446780\remote\win64_save"
$destinationFolder = "D:\Path\to\backups\folder"
$maxFileCount = 20

# Copy files with mirroring
robocopy "$sourceFolder" "$destinationFolder" /mir

# Count files in destination folder
$fileCount = (Get-ChildItem -Path $destinationFolder | Measure-Object).Count

# Delete oldest when max count is exceeded
if ($fileCount -gt $maxFileCount) {
    $filesToDelete = Get-ChildItem -Path $destinationFolder | Sort-Object LastWriteTime | Select-Object -First ($fileCount - $maxFileCount)
    $filesToDelete | ForEach-Object {
        Remove-Item $_.FullName -Force
        Write-Host "Deleted file: $($_.FullName)"
    }
}

