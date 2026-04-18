# boot configuration: grub, plymouth splash, and greetd auto-login

# hide grub menu, skip network wait on boot
grub2-editenv - set menu_auto_hide=1
systemctl disable NetworkManager-wait-online.service

# plymouth boot splash
dnf install -yq plymouth-system-theme
sed -i \
  -e 's/^BackgroundStartColor=.*/BackgroundStartColor=0x100f0f/' \
  -e 's/^BackgroundEndColor=.*/BackgroundEndColor=0x100f0f/' \
  -e 's/^ProgressBarBackgroundColor=.*/ProgressBarBackgroundColor=0x282726/' \
  -e 's/^ProgressBarForegroundColor=.*/ProgressBarForegroundColor=0xcecdc3/' \
  "/usr/share/plymouth/themes/spinner/spinner.plymouth"
plymouth-set-default-theme -R spinner

# greetd auto-login to niri
dnf copr enable avengemedia/danklinux -y
dnf install dms-greeter -yq
echo "$REAL_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/tmp-install
sudo -u "$REAL_USER" dms greeter enable
sudo -u "$REAL_USER" dms greeter sync
rm -f /etc/sudoers.d/tmp-install

if ! grep -q '^\[initial_session\]' /etc/greetd/config.toml; then
    tee -a /etc/greetd/config.toml >/dev/null <<EOF

[initial_session]
command = "niri-session"
user = "$REAL_USER"
EOF
fi
