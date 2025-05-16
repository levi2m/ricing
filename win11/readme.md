# Unified Installer: `install-all.ps1`

A single PowerShell wrapper that runs both the Komorebi and YASB installers and verifies their commands.

## Folder Structure

```

win11/
├── komorobi/
│   ├── install-komorobi.ps1
│   └── …
├── yasb/
│   ├── install-yasb.ps1
│   └── …
└── install-all.ps1

````

## What It Does

1. **Runs each installer**  
   - Launches `komorobi\install-komorobi.ps1`  
   - Launches `yasb\install-yasb.ps1`  
   Both in fresh PowerShell sessions with `-ExecutionPolicy Bypass`.

2. **Error Handling**  
   - If either script exits non-zero, the wrapper stops immediately and reports the failure.

3. **Post-Install Verification**  
   - Checks that the following commands are now available in your PATH:
     - `komorebi`
     - `whkd`
     - `yasb`

4. **Success Banner**  
   - If all checks pass, you’ll see a “All installations and verifications passed!” message.

## Prerequisites

- **Windows 10 or later**  
- **Run as Administrator** (to allow registry edits & installations)  
- **Winget** on your PATH  

## Usage

1. Open an elevated PowerShell prompt.  
2. `cd` into the `win11/` folder.  
3. Execute:

   ```powershell
   .\install-all.ps1
   ```

4. Wait for both installers to complete.
5. On success, you can launch:

   ```powershell
   komorebi --help
   whkd --help
   yasb --help
   ```
