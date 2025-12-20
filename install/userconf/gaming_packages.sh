#!/bin/bash

# -----------------------------
# Gaming Packages
# -----------------------------
if gum confirm "Install Gaming Packages?"; then
    sudo dnf install -y steam
    flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub org.prismlauncher.PrismLauncher
fi

gum style \
  --foreground 2 \
  --bold \
  "✔ Gaming packages installed"
