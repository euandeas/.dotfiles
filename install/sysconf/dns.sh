# cloudflare dns with dns-over-tls via systemd-resolved, quad9 fallback

mkdir -p /etc/systemd/
tee /etc/systemd/resolved.conf >/dev/null <<EOF
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 9.9.9.9#dns.quad9.net 2620:fe::fe#dns.quad9.net
DNSOverTLS=opportunistic
DNSStubListenerExtra=::1
EOF

systemctl restart systemd-resolved

active_con=$(nmcli -t -f NAME,DEVICE con show --active | head -1 | cut -d: -f1)
if [[ -n "$active_con" ]]; then
    nmcli connection modify "$active_con" ipv4.ignore-auto-dns yes
    nmcli connection modify "$active_con" ipv6.ignore-auto-dns yes
    nmcli con up "$active_con"
fi
