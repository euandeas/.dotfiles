#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

export DOTS_INSTALL="$HOME/.dotfiles/install"

if ! sudo -n true 2>/dev/null; then
echo "This script requires sudo privileges."
if ! sudo -v; then
    echo "Failed to obtain sudo privileges."
    exit 1
fi
fi

sudo dnf install -y gum

#new_hostname=$(gum input --placeholder "Enter the new hostname")
#sudo hostnamectl set-hostname "$new_hostname"

#git_name=$(gum input --placeholder "Enter git username")
#git config --global user.name "$git_name"

#git_email=$(gum input --placeholder "Enter git email")
#git config --global user.email "$git_email"

# Install
source "$DOTS_INSTALL/sysconf/all.sh"
source "$DOTS_INSTALL/userconf/all.sh"

gum style \
  --foreground 2 \
  --bold \
  "✔ Installation completed"
