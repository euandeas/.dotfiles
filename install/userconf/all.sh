gum style --foreground 3 "▸ Installing base packages"
source "$DOTS_INSTALL/userconf/base_packages.sh"

gum style --foreground 3 "▸ Installing gaming packages"
source "$DOTS_INSTALL/userconf/gaming_packages.sh"

gum style --foreground 3 "▸ Stowing dotfiles"
run_logged "$DOTS_INSTALL/userconf/dots.sh"
