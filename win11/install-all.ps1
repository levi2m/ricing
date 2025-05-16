<#
    install-all.ps1
    — Runs komorobi\install-komorobi.ps1 and yasb\install-yasb.ps1 unattended
    — Verifies that the commands komorebi, whkd and yasb are available
    — Checks that the komorebi process is running
    — Confirms an autostart shortcut for Komorebi exists
#>

[CmdletBinding()]
param()

function Invoke-Script {
    param(
        [Parameter(Mandatory)][string]$ScriptPath
    )
    Write-Host "=== Running $ScriptPath ===" -ForegroundColor Cyan

    $scriptArgs = @(
        "-NoProfile"
        "-ExecutionPolicy","Bypass"
        "-File",$ScriptPath
    )
    $p = Start-Process -FilePath "powershell.exe" -ArgumentList $scriptArgs -Wait -PassThru
    if ($p.ExitCode -ne 0) {
        Write-Error "`n✗ $ScriptPath failed (exit code $($p.ExitCode)). Stopping."
        exit $p.ExitCode
    }
    Write-Host "✓ $ScriptPath completed successfully.`n" -ForegroundColor Green
}

function Assert-Command {
    param(
        [Parameter(Mandatory)][string]$Name
    )
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        Write-Error "✗ Command '$Name' not found in PATH."
        exit 1
    }
    Write-Host "✓ Command '$Name' is available." -ForegroundColor Green
}

function Assert-ProcessRunning {
    param(
        [Parameter(Mandatory)][string]$Name
    )
    $proc = Get-Process -Name $Name -ErrorAction SilentlyContinue
    if (-not $proc) {
        Write-Error "✗ Process '$Name' is not running."
        exit 1
    }
    Write-Host "✓ Process '$Name' is running (PID: $($proc.Id))." -ForegroundColor Green
}

function Assert-AutostartEntryExists {
    # Check Startup folder for a Komorebi shortcut
    $startupFolder = Join-Path $Env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup"
    $links = Get-ChildItem -Path $startupFolder -Filter '*.lnk' -ErrorAction SilentlyContinue |
             Where-Object { $_.BaseName -match '(?i)komorebi' }
    if (-not $links) {
        Write-Error "✗ No autostart shortcut for Komorebi found in:`n    $startupFolder"
        exit 1
    }
    foreach ($lnk in $links) {
        Write-Host "✓ Found autostart shortcut: $($lnk.Name)" -ForegroundColor Green
    }
}

# ——— Main ———
Write-Host "`n=== Unified Komorebi + YASB Installer ===`n" -ForegroundColor Yellow

# Base folder (win11/)
$BaseDir = Split-Path $MyInvocation.MyCommand.Definition -Parent

# Run each installer
Invoke-Script -ScriptPath (Join-Path $BaseDir 'komorobi\install-komorobi.ps1')
Invoke-Script -ScriptPath (Join-Path $BaseDir 'yasb\install-yasb.ps1')

# Verify binaries
Assert-Command -Name 'komorebi'
Assert-Command -Name 'whkd'
Assert-Command -Name 'yasb'

# Give Komorebi a moment to launch
Start-Sleep -Seconds 2

# Verify Komorebi process
Assert-ProcessRunning -Name 'komorebi'

# Verify autostart entry
Assert-AutostartEntryExists

Write-Host "`nAll installations, verifications, and autostart checks passed! 🎉" -ForegroundColor Yellow
