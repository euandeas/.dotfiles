# Steam, Bottles, and Prism Launcher via dnf and flatpak

if [[ -n "${INSTALL_GAMING:-}" ]]; then
    dnf install -yq steam
    flatpak install -y --noninteractive flathub com.usebottles.bottles
    flatpak install -y --noninteractive flathub org.prismlauncher.PrismLauncher
fi
