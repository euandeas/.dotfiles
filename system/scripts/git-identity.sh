#!/usr/bin/env bash
# bootstrap task: ask for a git identity once.
set -euo pipefail
[[ -t 0 ]] || exit 0
if [[ -z "$(git config --global user.name || true)" ]]; then
    read -r -p "git user.name: " name && [[ -n "$name" ]] && git config --global user.name "$name"
fi
if [[ -z "$(git config --global user.email || true)" ]]; then
    read -r -p "git user.email: " email && [[ -n "$email" ]] && git config --global user.email "$email"
fi
