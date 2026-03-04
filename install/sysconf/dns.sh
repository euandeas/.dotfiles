#!/bin/bash

# -----------------------------
# Optimize DNS
# -----------------------------
sudo mkdir -p /etc/systemd/
sudo tee /etc/systemd/resolved.conf >/dev/null <<EOF
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
FallbackDNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
DNSOverTLS=opportunistic
EOF

sudo systemctl restart systemd-resolved
sudo nmcli connection modify enp11s0 ipv4.ignore-auto-dns yes
sudo nmcli con up enp11s0

gum style \
  --foreground 2 \
  --bold \
  "DNS settings applied"
