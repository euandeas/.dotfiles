# .dotfiles

Personal dotfiles configuration optimized for **Fedora** and **DMS (Dank Linux)**, featuring the **niri** tiling window manager.

This repository contains my personal configuration for a streamlined, privacy-focused, and efficient Linux workflow. It automates the setup of system packages, media codecs, repositories, and user-specific configurations using `stow`.

## Quick Start

### 1. Install Fedora (Base System)

1. Download the Fedora online installer from the [Fedora Project](https://fedoraproject.org/misc/#everything).
2. During installation, navigate to **Software Selection**:
   - **Base Environment**: Select `Fedora Custom Operating System`
   - **Additional Software**: Ensure the following are checked:
     - `Common NetworkManager Submodules`
     - `Standard`
3. Complete the installation and reboot.

### 2. Install DMS (Dank Linux)

Once Fedora is running, install the DMS environment:

```bash
curl -fsSL https://install.danklinux.com | sh
```

For more details on DMS, visit the [DMS Documentation](https://danklinux.com/docs/getting-started).

### 3. Clone and Install Dotfiles

Clone this repository and run the automated installer:

```bash
cd ~
git clone https://github.com/euandeas/.dotfiles
cd .dotfiles
./install.sh
```

## Installation Script Structure

The `install.sh` script orchestrates the setup process by executing modular scripts organized into two main categories: System Configuration (sysconf) and User Configuration (userconf).

```
.
├── dnf.packages              # Default packages installed via DNF
├── flatpak.packages          # Default packages installed via Flatpak
├── sysconf                   # System-level configurations
│   ├── all.sh                # Master execution script for system configs
│   ├── codecs.sh             # Media & Hardware Codecs (AMD optimized)
│   ├── dnf.sh                # DNF optimizations & automatic installs
│   ├── dns.sh                # DNS configuration
│   ├── firmware.sh           # Firmware update checks
│   ├── repos.sh              # Installs RPMFusion and Terra repositories
│   └── startup.sh            # Plymouth, Greetd, and Grub setup
└── userconf                  # User-level configurations
    ├── all.sh                # Master execution script for user configs
    ├── base_packages.sh      # Installs essential user packages
    ├── dots.sh               # Symlinks config files using GNU Stow
    └── gaming_packages.sh    # Installs gaming-specific dependencies
```

## Further Documentation

[Niri Documentation](https://niri-wm.github.io/niri/)

[DMS (Dank Linux) Docs](https://danklinux.com/docs/)

[Fedora Project](https://fedoraproject.org/)
