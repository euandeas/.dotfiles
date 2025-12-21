#!/bin/bash

# -----------------------------
# Update firmware
# -----------------------------
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update -y || { rc=$?; [[ $rc -ne 2 ]] && exit "$rc"; }

gum style \
  --foreground 2 \
  --bold \
  "Firmware updated"
