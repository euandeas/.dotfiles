#!/bin/bash

# -----------------------------
# Multimedia Codecs
# -----------------------------
sudo dnf4 group install multimedia -yq
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf upgrade @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -yq --skip-unavailable
sudo dnf group install -yq sound-and-video

# -----------------------------
# HW Accelerated Codecs
# -----------------------------
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld -y

gum style \
  --foreground 2 \
  --bold \
  "Codecs installed"
