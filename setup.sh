#!/bin/bash

# Function to check if user has sudo privileges
check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        echo "This script requires sudo privileges."
        if ! sudo -v; then
            echo "Failed to obtain sudo privileges"
            exit 1
        fi
    fi
}

check_sudo
echo " "
echo "Starting setup..."
echo " "

echo "Configuring DNS:"
cat ~/.dotfiles/resolved.conf
sudo cp ~/.dotfiles/resolved.conf /etc/systemd/
sudo systemctl restart systemd-resolved
echo " "

omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-light-theme.git > /dev/null 2>&1
echo "Flexoki Light Theme installed."
echo " "

omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-dark-theme.git > /dev/null 2>&1
echo "Flexoki Dark Theme installed."
echo " "

echo "Sym-Linking Config Files"
stow -v */
echo " "

echo "Installing Packages"
yay -S --noconfirm --needed brave ghostty zed obsidian-bin discord libreoffice-fresh stow syncthing-bin starship
