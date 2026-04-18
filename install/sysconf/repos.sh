# third-party repositories: rpm-fusion, terra, and flathub

# rpm-fusion and terra repos
dnf install -yq https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
if ! dnf repolist | grep -q '^terra\b'; then
    dnf install -yq --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
fi
dnf group upgrade core -yq
dnf4 group install core -yq

# flatpak
dnf install -yq flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak repair
flatpak update -y
