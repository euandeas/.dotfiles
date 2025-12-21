#!/bin/bash

# -----------------------------
# Gaming Packages
# -----------------------------
if gum confirm "Install Gaming Packages?"; then
    sudo dnf install -y -q steam
    flatpak install -y --noninteractive flathub com.usebottles.bottles
    flatpak install -y --noninteractive flathub org.prismlauncher.PrismLauncher
fi

gum style \
  --foreground 2 \
  --bold \
  "✔ Gaming packages installed"
