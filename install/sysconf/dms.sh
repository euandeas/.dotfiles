# DMS dsearch daemon

dnf install dsearch

uid=$(id -u "$REAL_USER")
sudo -u "$REAL_USER" \
  XDG_RUNTIME_DIR="/run/user/$uid" \
  DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$uid/bus" \
  systemctl --user enable --now dsearch
