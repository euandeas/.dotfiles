# logging and error handling

set -euo pipefail

LOG_FILE="/tmp/dotfiles-install-$(date '+%Y%m%d-%H%M%S').log"

# write a timestamped line to the log file
log() {
    echo "[$(date '+%H:%M:%S')] $*" >> "$LOG_FILE"
}

# run a subscript with all output logged to file
run_logged() {
    (source "$1") 2>&1 | awk '{ print "[" strftime("%H:%M:%S") "] " $0 }' >> "$LOG_FILE"
    echo >> "$LOG_FILE"
}

# colored output helpers
info() {
    printf '\033[33m%s\033[0m\n' "$*"
    log "$*"
}

success() {
    printf '\033[32m\033[1m%s\033[0m\n' "$*"
    log "$*"
}

error() {
    printf '\033[31m\033[1m%s\033[0m\n' "$*"
    log "$*"
}

confirm() {
    local prompt="$1"
    local response
    read -r -p "$prompt [Y/n] " response
    [[ -z "$response" || "$response" =~ ^[Yy] ]]
}

prompt_input() {
    local placeholder="$1"
    local response
    read -r -p "$placeholder: " response
    echo "$response"
}

on_error() {
    echo ""
    error "Installation failed"
    echo "Log: $LOG_FILE"
}
trap 'on_error' ERR

# log header written on source
{
    echo "────────────────────────────────────────"
    log "Dotfiles install started"
    echo "────────────────────────────────────────"
} >> "$LOG_FILE"
