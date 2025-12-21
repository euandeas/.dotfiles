#!/bin/bash

# -----------------------------
# Optimize DNF package manager for faster downloads and efficient updates
# -----------------------------
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
sudo dnf install dnf-plugins-core -y -q

# -----------------------------
# Enable and configure automatic system updates to enhance security and stability
# -----------------------------
sudo dnf install dnf-automatic -y -q
sudo mkdir -p /etc/dnf/
sudo tee /etc/dnf/automatic.conf >/dev/null <<EOF
[commands]
apply_updates=yes
EOF
sudo systemctl enable --now dnf-automatic.timer

gum style \
  --foreground 2 \
  --bold \
  "✔ DNF settings applied"
