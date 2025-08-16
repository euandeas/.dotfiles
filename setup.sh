#!/bin/bash

# Function to check if user has sudo privileges
check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        echo "This script requires sudo privileges."
        echo "Please enter your password:"
        if ! sudo -v; then
            echo "Failed to obtain sudo privileges"
            exit 1
        fi
    fi
}

check_sudo
echo "Sudo privileges confirmed. Running script..."

omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-light-theme.git
echo "Flexoki Light Theme installed."
echo " "
omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-dark-theme.git
echo "Flexoki Dark Theme installed."
echo " "

yay -S brave ghostty zed obsidian-bin discord libreoffice-fresh stow
