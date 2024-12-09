# Cursor Device ID Changer for Windows

## Overview
This PowerShell script allows you to change the device ID for the Cursor editor on Windows systems. It's useful when you need to reset your device identification, such as when experiencing account locking issues.

## Features
- Automatically generate a new random device ID
- Create an automatic backup of the original configuration file
- Support for custom device ID input
- Uses native PowerShell capabilities
- No additional dependencies required

## Prerequisites
- Windows operating system
- PowerShell (default on most Windows systems)
- Cursor editor installed

## Installation
1. Download the `change_cursor_id.ps1` script
2. (Optional) Place the script in a convenient location

## Usage

### Running the Script
Open PowerShell and navigate to the script's directory, then use one of these methods:

#### Method 1: Generate Random ID
```powershell
.\change_cursor_id.ps1
```

#### Method 2: Use Custom ID
```powershell
.\change_cursor_id.ps1 your_custom_id
```

### Important Notes
- Ensure Cursor editor is closed before running the script
- The script creates a backup of the original configuration file
- Backup files are saved with a timestamp in the same directory
- Backup filename format: `storage.json.backup_YYYYMMDD_HHMMSS`

## Configuration File Location
Default configuration file path:
```
%APPDATA%\Cursor\User\globalStorage\storage.json
```

## Execution Policy
If you encounter a security warning, you may need to adjust the PowerShell execution policy:

1. Open PowerShell as Administrator
2. Run:
```powershell
Set-ExecutionPolicy RemoteSigned
```

## Disclaimer
This script is provided for educational and troubleshooting purposes. Use at your own risk. It may potentially violate Cursor's terms of service.

## License
MIT License - Feel free to modify and distribute

## Support
No official support provided. Use at your own discretion.