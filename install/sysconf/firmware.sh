#!/bin/bash

# -----------------------------
# Update firmware
# -----------------------------
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update -y || true

gum style \
  --foreground 2 \
  --bold \
  "Firmware updated"
