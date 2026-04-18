# cloudflare dns with dns-over-tls via systemd-resolved, quad9 fallback

mkdir -p /etc/systemd/
tee /etc/systemd/resolved.conf >/dev/null <<EOF
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
FallbackDNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
DNSOverTLS=opportunistic
EOF

systemctl restart systemd-resolved

active_con=$(nmcli -t -f NAME,DEVICE con show --active | head -1 | cut -d: -f1)
if [[ -n "$active_con" ]]; then
    nmcli connection modify "$active_con" ipv4.ignore-auto-dns yes
    nmcli con up "$active_con"
fi
