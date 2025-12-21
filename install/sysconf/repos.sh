#!/bin/bash

# -----------------------------
# Enable RPM-Fusion
# -----------------------------
sudo dnf install -yq https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
if ! sudo dnf repolist | grep -q '^terra\b'; then
    sudo dnf install -yq --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
fi
sudo dnf group upgrade core -yq
sudo dnf4 group install core -yq

# -----------------------------
# Enable Flatpak
# -----------------------------
sudo dnf install -yq flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak repair
flatpak update -y

gum style \
  --foreground 2 \
  --bold \
  "Repositories enabled"
