gum style --foreground 3 "▸ Configuring DNS"
run_logged "$DOTS_INSTALL/sysconf/dns.sh"

gum style --foreground 3 "▸ Optimizing DNF"
run_logged "$DOTS_INSTALL/sysconf/dnf.sh"

gum style --foreground 3 "▸ Enabling repositories"
run_logged "$DOTS_INSTALL/sysconf/repos.sh"

gum style --foreground 3 "▸ Updating firmware"
run_logged "$DOTS_INSTALL/sysconf/firmware.sh"

gum style --foreground 3 "▸ Installing codecs"
run_logged "$DOTS_INSTALL/sysconf/codecs.sh"

gum style --foreground 3 "▸ Configuring startup"
run_logged "$DOTS_INSTALL/sysconf/startup.sh"

gum style --foreground 3 "▸ Setting up DMS"
run_logged "$DOTS_INSTALL/sysconf/dms.sh"
