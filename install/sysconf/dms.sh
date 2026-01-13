#!/bin/bash

# -----------------------------
# dsearch setup
# -----------------------------
sudo dnf install dsearch
systemctl --user enable --now dsearch
