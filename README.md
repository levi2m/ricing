

<p align="center">
  <a href="https://github.com/levi2m/ricing"></a>
</p>
<h1 align="center">💎 Ricing Dotfiles</h1>
<p align="center"><em>My Windows & Debian ricing dotfiles — streamline your setup with Komorebi, YASB & more</em></p>

<p align="center">
  <a href="https://github.com/levi2m/ricing/stargazers">
    <img src="https://img.shields.io/github/stars/levi2m/ricing?style=social" alt="GitHub Stars"/>
  </a>
  <a href="https://github.com/levi2m/ricing/issues">
    <img src="https://img.shields.io/github/issues/levi2m/ricing" alt="Issues"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/levi2m/ricing" alt="License"/>
  </a>
</p>


## 🚀 Features

- **Komorebi** – Tiled window manager wrapper for Windows 11, configurable via JSON and autostart scripts  
- **YASB** – Python-based, highly customizable status bar (widgets: CPU, memory, Cava audio visualizer, battery, network…)  
- **Automated installers** – One-click PowerShell scripts for Komorebi, YASB, or both (`install-komorobi.ps1`, `install-yasb.ps1`, `install-all.ps1`)  
- **Debian dotfiles** – (Coming soon) i3, Polybar, Alacritty, Zsh, and more for your Linux “rice”  


## 📁 Repository Structure

```bash
/
├── .github/
│   └── ISSUE_TEMPLATE.md
├── win11/
│   ├── komorobi/
│   │   ├── install-komorobi.ps1    # Komorebi installer + config deployment
│   │   ├── komorebi.json           # Main layout & gaps
│   │   ├── komorebi.bar.json       # Bar widget definitions
│   │   └── whkdrc                  # whkd config for key-bindings
│   ├── yasb/
│   │   ├── install-yasb.ps1        # YASB installer + config deployment
│   │   ├── config.yaml             # Status bar config
│   │   └── styles.scss             # Theme & style definitions
│   └── install-all.ps1             # Unified installer + post-install checks
├── LICENSE                         # GPL-2.0 License
└── README.md                       # ← You are here
````


## 💻 Getting Started

### Prerequisites

* **Windows 11** (or Debian Linux for upcoming scripts)
* **PowerShell 7+** on Windows
* **Windows Package Manager (Winget)** on Windows
* **(Future)** Git, Zsh, and your distro’s package manager on Debian

### Windows 11 Setup

1. **Clone the repo**

   ```powershell
   git clone https://github.com/levi2m/ricing.git
   cd ricing\win11
   ```
2. **Run the unified installer**

   ```powershell
   .\install-all.ps1
   ```
3. **Verify installation**

   ```powershell
   komorebi --help
   yasb --help
   ```

### Debian Setup

> 🚧 *Work in progress!* Detailed instructions coming soon for i3, Polybar, Alacritty, Zsh, etc.

---

## 🔧 Configuration

* **Komorebi**
  Edit `win11/komorobi/komorebi.json` & `komorebi.bar.json` to tweak layouts, gaps, fonts, and widget positions.

* **YASB**
  Adjust `win11/yasb/config.yaml` for widget selection and order, then (if you have Sass) compile:

  ```bash
  sass styles.scss styles.css
  ```

---

## 📝 Usage

* **Start Komorebi**

  ```powershell
  komorebic start --config "$Env:USERPROFILE\komorebi.json"
  ```

* **Enable Komorebi autostart (if the script fails to do so)**

  ```powershell
  komorebic enable-autostart --config "$Env:USERPROFILE\komorebi.json"
  ```

* **Launch YASB**

  ```powershell
  yasb
  ```

---

## 🤝 Contributing

Found a bug or have a feature in mind? Feel free to open an issue or submit a PR:

1. Fork this repo
2. Create a branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m "Add awesome feature"`)
4. Push to your branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## 📜 License

This project is licensed under the **GPL-2.0** License. See [LICENSE](LICENSE) for details.

---

*Happy Ricing!* 🚀