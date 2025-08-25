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
echo
echo "Starting setup..."
echo

echo "Configuring DNS:"
cat ~/.dotfiles/resolved.conf
sudo cp ~/.dotfiles/resolved.conf /etc/systemd/
sudo systemctl restart systemd-resolved
echo

omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-light-theme.git >/dev/null 2>&1
echo "Flexoki Light Theme installed."
echo

omarchy-theme-install https://github.com/euandeas/omarchy-flexoki-dark-theme.git >/dev/null 2>&1
echo "Flexoki Dark Theme installed."
echo
yay -S --noconfirm --needed stow

echo "Sym-Linking Config Files"
stow --adopt -v */
git restore .
echo


echo "Removing Some Omarchy Default Packages"
yay -R --noconfirm omarchy-chromium 1password-beta 1password-cli kdenlive signal-desktop typora pinta
omarchy-webapp-remove
echo

echo "Installing Default Packages"
yay -S --noconfirm --needed brave-bin ghostty-git zed vesktop syncthing flatpak proton-vpn-gtk-app
echo


read -p "Install Gaming Packages? (Y/n): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    yay -S --noconfirm --needed steam
    flatpak install flathub com.usebottles.bottles -y
    echo
fi
