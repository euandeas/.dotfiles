info "▸ Configuring DNS"
run_logged "$DOTS_INSTALL/sysconf/dns.sh"

info "▸ Optimizing DNF"
run_logged "$DOTS_INSTALL/sysconf/dnf.sh"

info "▸ Enabling repositories"
run_logged "$DOTS_INSTALL/sysconf/repos.sh"

info "▸ Updating firmware"
run_logged "$DOTS_INSTALL/sysconf/firmware.sh"

info "▸ Installing codecs"
run_logged "$DOTS_INSTALL/sysconf/codecs.sh"

info "▸ Configuring startup"
run_logged "$DOTS_INSTALL/sysconf/startup.sh"

info "▸ Setting up DMS"
run_logged "$DOTS_INSTALL/sysconf/dms.sh"
