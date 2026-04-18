# firmware updates via fwupdmgr

# fwupdmgr returns non-zero when no updates are available
set +e
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update
set -e
