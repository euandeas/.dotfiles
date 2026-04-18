#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges."
    exec sudo "$0" "$@"
fi

# track original user for commands that must run unprivileged
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
export REAL_USER REAL_HOME
export DOTS_INSTALL="$REAL_HOME/.dotfiles/install"

clear

source "$DOTS_INSTALL/util.sh"

dnf install -yq gum

clear

if gum confirm "Set hostname?"; then
    new_hostname=$(gum input --placeholder "Enter the new hostname")
    hostnamectl set-hostname "$new_hostname"
fi

if gum confirm "Configure git?"; then
    git_name=$(gum input --placeholder "Enter git username")
    sudo -u "$REAL_USER" git config --global user.name "$git_name"

    git_email=$(gum input --placeholder "Enter git email")
    sudo -u "$REAL_USER" git config --global user.email "$git_email"
fi

source "$DOTS_INSTALL/sysconf/all.sh"
source "$DOTS_INSTALL/userconf/all.sh"

gum style \
  --foreground 2 \
  --bold \
  "Installation completed"
echo "Log: $LOG_FILE"
