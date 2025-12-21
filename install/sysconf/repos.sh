#!/bin/bash

# -----------------------------
# Enable RPM-Fusion
# -----------------------------
sudo dnf install -y -q https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y -q https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
if ! sudo dnf repolist | grep -q '^terra\b'; then
    sudo dnf install -y -q --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
fi
sudo dnf update @core -y

# -----------------------------
# Enable Flatpak
# -----------------------------
sudo dnf install -y -q flatpak
flatpak remote-delete fedora --force || true
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak repair
flatpak update -y

gum style \
  --foreground 2 \
  --bold \
  "✔ Repositories enabled"
