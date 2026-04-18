gum style --foreground 3 "▸ Installing base packages"
if gum confirm "Install tailscale?"; then
    export INSTALL_TAILSCALE=1
fi
run_logged "$DOTS_INSTALL/userconf/base_packages.sh"

gum style --foreground 3 "▸ Installing gaming packages"
if gum confirm "Install Gaming Packages?"; then
    export INSTALL_GAMING=1
fi
run_logged "$DOTS_INSTALL/userconf/gaming_packages.sh"

gum style --foreground 3 "▸ Stowing dotfiles"
run_logged "$DOTS_INSTALL/userconf/dots.sh"
