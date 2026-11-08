#!/usr/bin/env bash
# post-dotfiles: let Syncthing and LocalSend through firewalld's default zone.
# firewalld ships the syncthing service; localsend comes from system/firewalld/localsend.xml
# (installed to /etc/firewalld/services by [bootstrap.files]). Safe to re-run.
set -euo pipefail
command -v firewall-cmd >/dev/null || exit 0
systemctl is-active --quiet firewalld || exit 0

# A new service file is only known to the permanent config after a reload.
if ! sudo firewall-cmd --permanent --get-services | tr ' ' '\n' | grep -qx localsend; then
    sudo firewall-cmd --reload >/dev/null
fi

zone="$(firewall-cmd --get-default-zone)"
changed=0
for svc in syncthing localsend; do
    if ! sudo firewall-cmd --permanent --zone="$zone" --query-service="$svc" >/dev/null; then
        sudo firewall-cmd --permanent --zone="$zone" --add-service="$svc" >/dev/null
        echo "firewall: allowed $svc in zone $zone"
        changed=1
    fi
done
if ((changed)); then sudo firewall-cmd --reload >/dev/null; fi
