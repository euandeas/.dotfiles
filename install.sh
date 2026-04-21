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

if confirm "Set hostname?"; then
    clear
    new_hostname=$(prompt_input "Enter the new hostname")
    hostnamectl set-hostname "$new_hostname"
fi
clear

if confirm "Configure git?"; then
    clear
    git_name=$(prompt_input "Enter git username")
    sudo -u "$REAL_USER" git config --global user.name "$git_name"
    clear
    git_email=$(prompt_input "Enter git email")
    sudo -u "$REAL_USER" git config --global user.email "$git_email"
fi
clear

source "$DOTS_INSTALL/sysconf/all.sh"
source "$DOTS_INSTALL/userconf/all.sh"

success "Installation completed"
echo "Log: $LOG_FILE"
