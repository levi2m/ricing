# Komorebi Windows Setup

This folder contains:

```

win11/
└── komorobi/
├── komorobi.bar.json
├── komorobi.json
├── whkdrc
├── install-komorobi.ps1
└── README.md

````

## Prerequisites

1. **Windows 10 or later.**  
2. **Windows Package Manager (Winget)** installed and on your PATH.  
3. **Enable Long Paths** (recommended for proper file handling):  
   ```powershell
   Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
````

4. **Disable unnecessary system animations** for best performance:

   * Open **Control Panel > Ease of Access > Make the computer easier to see**
   * Check **Turn off all unnecessary animations**.

> Both Komorebi and whkd are available via Winget — no manual MSI download needed. ([lgug2z.github.io][1])

## What the Script Does

**install-komorobi.ps1** will:

1. Check that it’s running on Windows 10 / 11.
2. Verify Winget is installed and on `$Env:Path`.
3. Optionally enable long-path support if it isn’t already.
4. Search Winget for the Komorebi (`LGUG2Z.komorebi`) and whkd (`LGUG2Z.whkd`) packages.
5. Install both packages with `winget install -e --id ...`.
6. Confirm installation by checking that `komorebi` and `whkd` commands are available.

## Usage

Open PowerShell **as Administrator** and run:

```powershell
cd path\to\win11\komorobi
.\install-komorobi.ps1
```

Once complete, you can launch:

```powershell
komorebi --help
whkd --help
```