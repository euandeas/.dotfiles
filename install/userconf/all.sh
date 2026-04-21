info "▸ Installing base packages"
if confirm "Install tailscale?"; then
    export INSTALL_TAILSCALE=1
fi
run_logged "$DOTS_INSTALL/userconf/base_packages.sh"

if confirm "Install Gaming Packages?"; then
    info "▸ Installing gaming packages"
    export INSTALL_GAMING=1
fi
run_logged "$DOTS_INSTALL/userconf/gaming_packages.sh"

info "▸ Stowing dotfiles"
run_logged "$DOTS_INSTALL/userconf/dots.sh"
