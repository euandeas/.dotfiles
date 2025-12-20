#!/bin/bash

# -----------------------------
# Multimedia Codecs
# -----------------------------
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf update @sound-and-video -y

# -----------------------------
# HW Accelerated Codecs
# -----------------------------
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld -y

gum style \
  --foreground 2 \
  --bold \
  "✔ Codecs installed"
