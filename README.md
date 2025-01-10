# Cursor Device ID Changer for Windows

## Origin
Original macOS version: [GitHub - fly8888/cursor_machine_id](https://github.com/fly8888/cursor_machine_id)

## Overview
This PowerShell script allows you to change the device ID for the Cursor editor on Windows systems. It's particularly useful when experiencing account locking issues or when you need to reset your device identification.

## Features
- ✨ Automatically generate new random device IDs
- 💾 Create automatic backups of the original configuration file
- 🛠️ Updates all telemetry identifiers:
  - machineId
  - macMachineId
  - devDeviceId
  - sqmId
- 🔒 Safety checks to ensure Cursor is closed before modifications
- 📦 No additional dependencies required

## Prerequisites
- Windows operating system
- PowerShell (default on most Windows systems)
- Cursor editor installed

## Installation
1. Download the `change_cursor_id.ps1` script
2. (Optional) Place the script in a convenient location

## Usage
Open PowerShell and navigate to the script's directory, then run:

```powershell
.\change_cursor_id.ps1
```

## Important Notes
- ⚠️ If issues persist after reset, try:
  1. Deleting your account
  2. Resetting device ID
  3. Restarting Cursor
  4. Creating a new account
- The script automatically creates timestamped backups
- Backup format: `storage.json.backup_YYYYMMDD_HHMMSS`
- Ensure Cursor is completely closed before running

## Configuration File Location
Default configuration file path:
```
%APPDATA%\Cursor\User\globalStorage\storage.json
```

## Execution Policy
If you encounter a security warning, adjust the PowerShell execution policy:

1. **Unlock the Script**:
   - Right-click on the script file
   - Select **Properties**
   - Check for an "Unlock" button in the **General** tab
   - Click "Unlock" to remove restrictions

2. **Adjust Execution Policy**:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

## Disclaimer
This script is provided for troubleshooting purposes. Use at your own risk.

## License
MIT License

## Support
No official support provided. Use at your own discretion.