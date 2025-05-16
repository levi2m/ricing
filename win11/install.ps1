# 1) clone your repo
$dest = "$env:USERPROFILE\komorebi-yasb-config"
git clone https://github.com/levi2m/ricing/win11.git $dest

# 2) copy config files
$kdir = "$env:USERPROFILE"
Copy-Item "$dest\komorebi\*" $kdir -Recurse -Force
Copy-Item "$dest\yasb\*"     $kdir -Recurse -Force

# 3) install YASB Python deps
pip install --user -r "$dest\yasb\requirements.txt"

Write-Host "✅ Setup complete. Run `komorebic start` and then `python -m yasb` "
