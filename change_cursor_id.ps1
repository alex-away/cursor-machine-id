# Cursor Device ID Changer for Windows
# PowerShell adaptation of the original macOS script
# Original source: https://github.com/fly8888/cursor_machine_id
# PowerShell script to modify Cursor editor's device ID

# Configuration file path
$STORAGE_FILE = "$env:APPDATA\Cursor\User\globalStorage\storage.json"

# Function to generate hex ID using RNGCryptoServiceProvider (40-character hex)
function Generate-CryptoRandomHex {
    $bytes = New-Object Byte[] 32
    $rng = New-Object Security.Cryptography.RNGCryptoServiceProvider
    $rng.GetBytes($bytes)
    $rng.Dispose()
    return -join ($bytes | ForEach-Object { $_.ToString('x2') })
}

# Function to generate UUID with braces
function Generate-BracedUUID {
    $guid = [guid]::NewGuid()
    return "{$($guid.ToString().ToUpper())}"
}

# Function to generate standard UUID
function Generate-StandardUUID {
    return [guid]::NewGuid().ToString()
}

# Function to create a backup of the storage file
function Backup-StorageFile {
    if (Test-Path $STORAGE_FILE) {
        $backupPath = "$STORAGE_FILE.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item -Path $STORAGE_FILE -Destination $backupPath -Force
        Write-Host "Backup created: $backupPath"
    }
}

# Check if Cursor is running
$cursorProcess = Get-Process "Cursor" -ErrorAction SilentlyContinue
if ($cursorProcess) {
    Write-Host "Please close Cursor editor before running this script." -ForegroundColor Red
    exit 1
}

# Ensure the directory exists
$storageDir = Split-Path -Parent $STORAGE_FILE
if (-not (Test-Path $storageDir)) {
    New-Item -ItemType Directory -Path $storageDir -Force | Out-Null
}

# Create an empty JSON file if it doesn't exist
if (-not (Test-Path $STORAGE_FILE)) {
    '{}' | Out-File -FilePath $STORAGE_FILE -Encoding UTF8
}

try {
    # Backup the existing file
    Backup-StorageFile

    # Generate new IDs using the same logic as the original script
    $machineId = Generate-CryptoRandomHex
    $macMachineId = Generate-CryptoRandomHex
    $sqmId = Generate-BracedUUID
    $devDeviceId = Generate-StandardUUID

    # Read the current JSON content
    $jsonContent = Get-Content $STORAGE_FILE -Raw | ConvertFrom-Json
    if (-not $jsonContent) { $jsonContent = [PSCustomObject]@{} }

    # Update all telemetry IDs
    $jsonContent.'telemetry.machineId' = $machineId
    $jsonContent.'telemetry.macMachineId' = $macMachineId
    $jsonContent.'telemetry.devDeviceId' = $devDeviceId
    $jsonContent.'telemetry.sqmId' = $sqmId

    # Save the updated JSON
    $jsonContent | ConvertTo-Json -Depth 10 | Set-Content $STORAGE_FILE -Encoding UTF8

    Write-Host "`nSuccessfully updated device IDs:"
    Write-Host "machineId: $machineId"
    Write-Host "macMachineId: $macMachineId"
    Write-Host "devDeviceId: $devDeviceId"
    Write-Host "sqmId: $sqmId"
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}