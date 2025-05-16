
```powershell
<# 
    install-komorobi.ps1
    Installs Komorebi (LGUG2Z.komorebi) and whkd (LGUG2Z.whkd) via Winget,
    performing pre-flight checks for OS version, Winget, long-path support.
#>

# No parameters needed

function Assert-Windows10OrHigher {
    $v = [Environment]::OSVersion.Version
    if ($v.Major -lt 10) {
        Write-Error "Windows 10 or later is required. Detected version: $v"
        exit 1
    }
}

function Assert-WingetPresent {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Error "Winget not found. Please install the Windows Package Manager first."
        exit 1
    }
}

function Enable-LongPaths {
    $regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
    $current = Get-ItemProperty -Path $regPath -Name LongPathsEnabled -ErrorAction SilentlyContinue
    if ($current.LongPathsEnabled -ne 1) {
        Write-Host "Enabling long paths support..."
        try {
            Set-ItemProperty -Path $regPath -Name LongPathsEnabled -Value 1 -ErrorAction Stop
            Write-Host "✓ Long paths enabled."
        } catch {
            Write-Warning "Failed to enable LongPaths. Run as Administrator and try again."
        }
    } else {
        Write-Host "Long paths support already enabled."
    }
}

function Install-PackageIfNeeded {
    param (
        [string]$PackageId
    )
    $found = winget search --id $PackageId --source winget | Select-String $PackageId
    if (-not $found) {
        Write-Error "Package '$PackageId' not found in Winget."
        exit 1
    }
    Write-Host "Installing $PackageId..."
    winget install --id $PackageId --exact --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Installation of $PackageId failed."
        exit 1
    }
    Write-Host "✓ $PackageId installed."
}

function Assert-CommandExists {
    param (
        [string]$Cmd
    )
    if (-not (Get-Command $Cmd -ErrorAction SilentlyContinue)) {
        Write-Error "Command '$Cmd' not available after installation."
        exit 1
    }
}

# --- Main ---
Write-Host "=== Komorebi & whkd Installer ==="
Assert-Windows10OrHigher
Assert-WingetPresent
Enable-LongPaths

# Install Komorebi and whkd
Install-PackageIfNeeded -PackageId 'LGUG2Z.komorebi'   # :contentReference[oaicite:1]{index=1}
Install-PackageIfNeeded -PackageId 'LGUG2Z.whkd'       # :contentReference[oaicite:2]{index=2}

# Verify
Assert-CommandExists -Cmd 'komorebi'
Assert-CommandExists -Cmd 'whkd'

Write-Host "`nAll done! You can now run 'komorebi' and 'whkd' from PowerShell."
