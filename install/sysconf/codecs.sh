# multimedia and hardware-accelerated codecs via dnf swaps

# multimedia codecs
dnf4 group install multimedia -yq
dnf swap ffmpeg-free ffmpeg --allowerasing -y
dnf upgrade @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -yq --skip-unavailable
dnf group install -yq sound-and-video

# hardware accelerated codecs (AMD)
dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld -y
