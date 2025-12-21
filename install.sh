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

sudo dnf install -y -q gum

new_hostname=$(gum input --placeholder "Enter the new hostname")
sudo hostnamectl set-hostname "$new_hostname"

git_name=$(git config --global --get user.name)

if [[ -z "$git_name" ]]; then
  git_name=$(gum input --placeholder "Enter git username")
  git config --global user.name "$git_name"
else
  echo "Git username already set: $git_name"
fi

git_email=$(git config --global --get user.email)

if [[ -z "$git_email" ]]; then
  git_email=$(gum input --placeholder "Enter git email")
  git config --global user.email "$git_email"
else
  echo "Git email already set: $git_email"
fi

# Install
source "$DOTS_INSTALL/sysconf/all.sh"
source "$DOTS_INSTALL/userconf/all.sh"

gum style \
  --foreground 2 \
  --bold \
  "✔ Installation completed"
