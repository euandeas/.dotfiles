#!/bin/bash

# -----------------------------
# Update firmware
# -----------------------------
set +e
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
set -e

gum style \
  --foreground 2 \
  --bold \
  "Firmware updated"
