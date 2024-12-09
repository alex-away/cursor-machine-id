# Cursor Device ID Changer for Windows
# PowerShell script to modify Cursor editor's device ID

# Configuration file path
$STORAGE_FILE = "$env:APPDATA\Cursor\User\globalStorage\storage.json"

# Function to generate a random ID
function Generate-RandomId {
    return -join ((48..57) + (97..102) | Get-Random -Count 64 | % {[char]$_})
}

# Check if a custom ID is provided as an argument
$NEW_ID = $args[0]
if (-not $NEW_ID) {
    $NEW_ID = Generate-RandomId
}

# Function to create a backup of the storage file
function Backup-StorageFile {
    if (Test-Path $STORAGE_FILE) {
        $backupPath = "$STORAGE_FILE.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item -Path $STORAGE_FILE -Destination $backupPath -Force
        Write-Host "Backup created: $backupPath"
    }
}

# Ensure the directory exists
$storageDir = Split-Path -Parent $STORAGE_FILE
if (-not (Test-Path $storageDir)) {
    New-Item -ItemType Directory -Path $storageDir | Out-Null
}

# Create an empty JSON file if it doesn't exist
if (-not (Test-Path $STORAGE_FILE)) {
    '{}' | Out-File -FilePath $STORAGE_FILE -Encoding UTF8
}

# Backup the existing file
Backup-StorageFile

# Read the current JSON content
$jsonContent = Get-Content $STORAGE_FILE -Raw | ConvertFrom-Json

# Update the machine ID
$jsonContent.'telemetry.machineId' = $NEW_ID

# Save the updated JSON
$jsonContent | ConvertTo-Json -Depth 10 | Set-Content $STORAGE_FILE -Encoding UTF8

Write-Host "Successfully changed machineId to: $NEW_ID"

# Provide usage instructions
Write-Host "`nUsage:"
Write-Host "  .\change_cursor_id.ps1           # Generate random ID"
Write-Host "  .\change_cursor_id.ps1 custom_id # Use custom ID"