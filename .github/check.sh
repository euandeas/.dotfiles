#!/usr/bin/env bash
# Check this repo before it reaches `mise bootstrap`:
#   config     every config parses without warnings (base + gaming + tailscale)
#   dotfiles   every [dotfiles] source exists and applies cleanly to an empty $HOME
#   niri       home/niri/local.kdl on top of Hafnium's niri config passes `niri validate`
#   lint       shellcheck on the scripts and .bashrc
#
#   .github/check.sh [hdots-checkout]
# Without an hdots checkout, the niri check is skipped. Needs mise, niri, shellcheck.
set -uo pipefail

repo="$(cd "$(dirname "$0")/.." && pwd)"
hdots="${1:-}"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
failed=()

# A throwaway $HOME where this repo is the global mise config, as after bootstrap
sandbox() {
    local h="$work/home"
    rm -rf "$h" && mkdir -p "$h/.config"
    cp -a "$repo" "$h/.dotfiles"
    ln -s ../.dotfiles "$h/.config/mise"
    echo "$h"
}
in_sandbox() { # in_sandbox <home> <command...>
    local h="$1"; shift
    # DOTFILES_CHECK makes hooks that touch the real system (firewall.sh) skip themselves
    (cd "$h" && DOTFILES_CHECK=1 HOME="$h" XDG_CONFIG_HOME="$h/.config" MISE_STATE_DIR="$work/state" \
        MISE_DATA_DIR="$work/data" MISE_CACHE_DIR="$work/cache" "$@")
}

echo "== config"
h="$(sandbox)"
for env in "" gaming tailscale gaming,tailscale; do
    out="$(in_sandbox "$h" mise ${env:+-E "$env"} dot status 2>&1 >/dev/null)"
    if grep -qE 'WARN|ERROR' <<<"$out"; then
        echo "config${env:+ ($env)}:"; echo "$out"; failed+=("config")
    else
        echo "config${env:+ ($env)}: ok"
    fi
done

echo "== dotfiles"
h="$(sandbox)"
# `status --missing` exits non-zero if anything is missing, differs or has no source
if in_sandbox "$h" mise dot apply --yes >"$work/apply.log" 2>&1 \
    && in_sandbox "$h" mise dot status --missing >/dev/null 2>&1; then
    echo "dotfiles: all entries applied"
else
    cat "$work/apply.log"; in_sandbox "$h" mise dot status; failed+=("dotfiles")
fi

echo "== niri"
if [[ -n "$hdots" ]]; then
    n="$work/niri" && mkdir -p "$n/cfg"
    cp -a "$hdots/dots/niri" "$n/share"
    sed -i "s|/usr/share/hafnium/dots/niri|$n/share|g" "$n/share/config.kdl"
    cp "$n/share/config.kdl" "$n/cfg/config.kdl"
    cp "$repo/home/niri/local.kdl" "$n/cfg/local.kdl"
    if niri validate -c "$n/cfg/config.kdl" >"$work/niri.log" 2>&1; then
        echo "niri: local.kdl is valid on top of Hafnium's config"
    else
        grep -vE 'optional include not found' "$work/niri.log"; failed+=("niri")
    fi
else
    echo "niri: skipped (no hdots checkout given)"
fi

echo "== lint"
# .bashrc: SC2076 (Fedora's stock literal PATH match) and SC2164 are intentional
if shellcheck -S warning "$repo"/system/scripts/*.sh \
    && shellcheck -S warning -s bash -e SC2076,SC2164 "$repo/home/bashrc"; then
    echo "lint: ok"
else
    failed+=("lint")
fi

echo
if ((${#failed[@]})); then echo "FAILED: $(printf '%s\n' "${failed[@]}" | sort -u | xargs)"; exit 1; fi
echo "all checks passed"
