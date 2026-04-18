# logging and error handling

set -euo pipefail

LOG_FILE="/tmp/dotfiles-install-$(date '+%Y%m%d-%H%M%S').log"

# run a subscript with all output logged to file
run_logged() {
    (source "$1") >>"$LOG_FILE" 2>&1
}

log() {
    echo "[$(date '+%H:%M:%S')] $*"
}

on_error() {
    echo ""
    if command -v gum &>/dev/null; then
        gum style --foreground 1 --bold "Installation failed"
    else
        echo "Installation failed"
    fi
    echo "Log: $LOG_FILE"
}
trap 'on_error' ERR
