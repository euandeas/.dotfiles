#!/bin/bash

# -----------------------------
# Stow Dotfiles
# -----------------------------
stow --adopt -v */
git restore . || true

# -----------------------------
# Font Cache
# -----------------------------
fc-cache -fv

gum style \
  --foreground 2 \
  --bold \
  "✔ Dotfiles installed"
