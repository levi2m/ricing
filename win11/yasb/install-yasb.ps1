<#
    install-yasb.ps1
    Installs YASB via Winget and deploys your config files.
#>

[CmdletBinding()]
param()

function Assert-Windows10OrHigher {
    $v = [Environment]::OSVersion.Version
    if ($v.Major -lt 10) {
        Write-Error "Windows 10 or later is required. Detected version: $v"
        exit 1
    }
}

function Assert-WingetPresent {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Error "Winget not found. Please install Windows Package Manager first."
        exit 1
    }
}

function Install-PackageIfNeeded {
    param([string]$PackageId)
    $found = winget search --id $PackageId --source winget |
             Select-String $PackageId
    if (-not $found) {
        Write-Error "Package '$PackageId' not found in Winget."
        exit 1
    }
    Write-Host "Installing $PackageId..."
    winget install --id $PackageId --exact `
        --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Installation of $PackageId failed."
        exit 1
    }
    Write-Host "✓ $PackageId installed."
}

function Initialize-YasbConfig {
    $cfg = Join-Path $Env:USERPROFILE '.config\yasb'
    if (-not (Test-Path $cfg)) {
        New-Item -ItemType Directory -Path $cfg -Force |
            Out-Null
    }
    Copy-Item -Path 'config.yaml' -Destination $cfg -Force
    if (Get-Command sass -ErrorAction SilentlyContinue) {
        Write-Host "Compiling styles.scss → styles.css..."
        sass styles.scss (Join-Path $cfg 'styles.css')
        Write-Host "✓ styles.css generated."
    } else {
        Write-Warning "Sass CLI not found; please install 'sass' to compile styles.scss."
    }
}

function Assert-CommandExists {
    param([string]$Cmd)
    if (-not (Get-Command $Cmd -ErrorAction SilentlyContinue)) {
        Write-Error "Command '$Cmd' not available after installation."
        exit 1
    }
}

# ——— Main ———
Write-Host "=== YASB Installer ==="
Assert-Windows10OrHigher
Assert-WingetPresent

Install-PackageIfNeeded -PackageId 'AmN.yasb'   # :contentReference[oaicite:1]{index=1}
Initialize-YasbConfig
Assert-CommandExists -Cmd 'yasb'

Write-Host "`nAll set! Run 'yasb' to launch your status bar."
