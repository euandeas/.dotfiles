#!/bin/bash

# -----------------------------
# Optimize DNS
# -----------------------------
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo tee /etc/systemd/resolved.conf.d/99-dns-over-tls.conf >/dev/null <<EOF
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
FallbackDNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
DNSOverTLS=opportunistic
EOF
sudo systemctl restart systemd-resolved

gum style \
  --foreground 2 \
  --bold \
  "✔ DNS settings applied"
