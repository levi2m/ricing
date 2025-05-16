<#
    install-all.ps1
    — Runs komorobi\install-komorobi.ps1 and yasb\install-yasb.ps1 unattended
    — Verifies that the commands komorebi, whkd and yasb are available
#>

[CmdletBinding()]
param()

function Invoke-Script {
    param(
        [Parameter(Mandatory)][string]$ScriptPath
    )
    Write-Host "=== Running $ScriptPath ===" -ForegroundColor Cyan

    # Launch in a fresh PowerShell process to respect -ExecutionPolicy Bypass etc.
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

# ——— Main ———
Write-Host "`n=== Unified Komorebi + YASB Installer ===`n" -ForegroundColor Yellow

# Determine base folder (win11/)
$BaseDir = Split-Path $MyInvocation.MyCommand.Definition -Parent

# Run each installer
Invoke-Script -ScriptPath (Join-Path $BaseDir 'komorobi\install-komorobi.ps1')
Invoke-Script -ScriptPath (Join-Path $BaseDir 'yasb\install-yasb.ps1')

# Verify binaries
Assert-Command -Name 'komorebi'
Assert-Command -Name 'whkd'
Assert-Command -Name 'yasb'

Write-Host "`nAll installations and verifications passed! 🎉" -ForegroundColor Yellow
