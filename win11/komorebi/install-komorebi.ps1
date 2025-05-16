<#
    install-komorobi.ps1
    Installs Komorebi (LGUG2Z.komorebi) via Winget,
    deploys config files, enables autostart for Komorebi only,
    then starts Komorebi with your configs.
#>

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

function Install-PackageIfNeeded {
    param([string]$PackageId)
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

function Set-KomorebiConfig {
    Write-Host "Deploying config files to your KOMOREBI_CONFIG_HOME (or %USERPROFILE%)..."
    $cfgHome = if ($Env:KOMOREBI_CONFIG_HOME) { $Env:KOMOREBI_CONFIG_HOME } else { $Env:USERPROFILE }
    foreach ($file in 'komorebi.json','komorebi.bar.json','whkdrc') {
        $src = Join-Path $PSScriptRoot $file
        if (Test-Path $src) {
            Copy-Item -Path $src -Destination (Join-Path $cfgHome $file) -Force
            Write-Host "✓ Copied $file → $cfgHome\$file"
        } else {
            Write-Warning "Config file '$file' not found in script folder."
        }
    }
    return $cfgHome
}

function Assert-CommandExists {
    param([string]$Cmd)
    if (-not (Get-Command $Cmd -ErrorAction SilentlyContinue)) {
        Write-Error "Command '$Cmd' not available after installation."
        exit 1
    }
}

# --- Main ---
Write-Host "=== Komorebi Installer + Config Setup ===" -ForegroundColor Cyan

Assert-Windows10OrHigher
Assert-WingetPresent

# Install Komorebi
Install-PackageIfNeeded -PackageId 'LGUG2Z.komorebi'   # from WinGet :contentReference[oaicite:0]{index=0}

# Deploy configs and grab the path
$configHome = Set-KomorebiConfig                          # :contentReference[oaicite:1]{index=1}

# Enable autostart for Komorebi only
Write-Host "Enabling Komorebi autostart..."
komorebic enable-autostart --config "$configHome\komorebi.json"  # :contentReference[oaicite:2]{index=2}

# Finally, launch Komorebi (no whkd/bar)
Write-Host "Starting Komorebi now..."
komorebic start --config "$configHome\komorebi.json"             # :contentReference[oaicite:3]{index=3}

# Verify binary is running
Assert-CommandExists -Cmd 'komorebi'

Write-Host "`nAll set! Komorebi is installed, configured, autostart-enabled, and running." -ForegroundColor Green
