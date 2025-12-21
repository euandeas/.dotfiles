#!/bin/bash

# -----------------------------
# DNF SPECIFIC REPOS
# -----------------------------
sudo dnf config-manager addrepo --overwrite --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.3-1.noarch.rpm -y -q
rm ./protonvpn-stable-release-1.0.3-1.noarch.rpm
sudo dnf check-update --refresh

# -----------------------------
# DNF
# -----------------------------
sudo dnf install -y -q $(grep -vE '^\s*#|^\s*$' "$DOTS_INSTALL/dnf.packages")
sudo dnf install gh --repo gh-cli -y -q

# -----------------------------
# Flatpak
# -----------------------------
while read -r app; do
  flatpak install -y --noninteractive flathub "$app"
done < "$DOTS_INSTALL/flatpak.packages"

gum style \
  --foreground 2 \
  --bold \
  "Base packages installed"
