# DNF performance tuning and automatic updates

# parallel downloads
if ! grep -q '^max_parallel_downloads' /etc/dnf/dnf.conf; then
    echo "max_parallel_downloads=10" | tee -a /etc/dnf/dnf.conf > /dev/null
fi
dnf install dnf-plugins-core -yq

# automatic updates
dnf install dnf-automatic -yq
mkdir -p /etc/dnf/
tee /etc/dnf/automatic.conf >/dev/null <<EOF
[commands]
apply_updates=yes
EOF
systemctl enable --now dnf-automatic.timer
