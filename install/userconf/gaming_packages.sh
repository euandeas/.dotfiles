# Steam, Bottles, and Prism Launcher via dnf and flatpak

if gum confirm "Install Gaming Packages?"; then
    dnf install -yq steam
    flatpak install -y --noninteractive flathub com.usebottles.bottles
    flatpak install -y --noninteractive flathub org.prismlauncher.PrismLauncher
fi
