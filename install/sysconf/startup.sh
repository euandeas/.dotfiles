#!/bin/bash

# -----------------------------
# Skip GRUB & NetworkManager
# -----------------------------
sudo grub2-editenv - set menu_auto_hide=1
sudo systemctl disable NetworkManager-wait-online.service

# -----------------------------
# Plymouth Setup
# -----------------------------
sudo dnf install -y plymouth-system-theme
sudo plymouth-set-default-theme bgrt

# -----------------------------
# Greetd Autologin
# -----------------------------
#sudo mkdir -p /etc/greetd/
#sudo tee /etc/greetd/config.toml >/dev/null <<EOF
#[terminal]
#vt = 1

#[initial_session]
#command = "niri-session"
#user = "euandeas"
#EOF

sudo dnf copr enable avengemedia/danklinux -y
sudo dnf install dms-greeter -y
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
