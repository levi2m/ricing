# YASB Windows Setup

This folder contains:

```

win11/
└── yasb/
├── config.yaml
├── styles.scss
├── yasb.log
├── install-yasb.ps1
└── README.md

````

## Prerequisites

1. **Windows 10 or later.**  
2. **Windows Package Manager (Winget)** installed and on your `PATH`.  
3. **(Optional) Sass CLI** if you want to compile `styles.scss` into `styles.css` yourself:  
   ```powershell
   npm install -g sass
````

4. **(Optional) Python 3.12 + Qt6** only if you plan to run from source instead of the Winget package.

> The official Winget package bundles a ready-to-run build, so you don’t need Python or Qt if you use Winget. ([GitHub][1])

## What the Script Does

**install-yasb.ps1** will:

1. Check you’re on Windows 10/11.
2. Verify Winget is available.
3. Install the YASB package (`AmN.yasb`).
4. Create your user config folder (`%USERPROFILE%\.config\yasb`).
5. Copy over `config.yaml` and, if you have `sass` on your `PATH`, compile `styles.scss` → `styles.css`.
6. Confirm the `yasb` command is callable.

## Usage

Open PowerShell **as Administrator**, navigate into this folder and run:

```powershell
cd path\to\win11\yasb
.\install-yasb.ps1
```

When it finishes, launch your bar with:

```powershell
yasb
```