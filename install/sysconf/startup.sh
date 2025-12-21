#!/bin/bash

# -----------------------------
# Skip GRUB & NetworkManager
# -----------------------------
sudo grub2-editenv - set menu_auto_hide=1
sudo systemctl disable NetworkManager-wait-online.service

# -----------------------------
# Plymouth Setup
# -----------------------------
sudo dnf install -y -q plymouth-system-theme
sudo sed -i \
  -e 's/^BackgroundStartColor=.*/BackgroundStartColor=0x100f0f/' \
  -e 's/^BackgroundEndColor=.*/BackgroundEndColor=0x100f0f/' \
  -e 's/^ProgressBarBackgroundColor=.*/ProgressBarBackgroundColor=0x282726/' \
  -e 's/^ProgressBarForegroundColor=.*/ProgressBarForegroundColor=0xcecdc3/' \
  "/usr/share/plymouth/themes/spinner/spinner.plymouth"
sudo plymouth-set-default-theme -R spinner

# -----------------------------
# Greetd Autologin
# -----------------------------
sudo dnf copr enable avengemedia/danklinux -y
sudo dnf install dms-greeter -y -q
dms greeter enable
dms greeter sync

sudo tee -a /etc/greetd/config.toml >/dev/null <<'EOF'

[initial_session]
command = "niri-session"
user = "euandeas"
EOF

gum style \
  --foreground 2 \
  --bold \
  "✔ Startup configuration applied"
