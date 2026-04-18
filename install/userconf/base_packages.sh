# packages from dnf and flatpak package lists

# third-party repos
dnf config-manager addrepo --overwrite --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf makecache --refresh

# dnf packages
mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$DOTS_INSTALL/dnf.packages")
if ((${#pkgs[@]} > 0)); then
    dnf install -yq "${pkgs[@]}"
fi
dnf install gh --repo gh-cli -yq

if [[ -n "${INSTALL_TAILSCALE:-}" ]]; then
    dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
    dnf install -yq tailscale
    systemctl enable --now tailscaled
fi

# flatpak packages
while read -r app; do
  flatpak install -y --noninteractive flathub "$app"
done < "$DOTS_INSTALL/flatpak.packages"
