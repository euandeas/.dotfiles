#!/usr/bin/env bash
# mise run davinci: install or update DaVinci Resolve Studio and the FFmpeg encoder
# plugin. Skips whatever is already at the latest version.
#
#   mise run davinci             install/update both
#   mise run davinci -- --force  reinstall Resolve even if it's current
#
# 1. Download the latest Resolve Studio for Linux from Blackmagic (about 11.5 GB).
#    Blackmagic hands out the link through its registration form; placeholder
#    details are sent, as the website's form would.
# 2. Install it as in my gist (gist.github.com/euandeas/e79c6e17d3fc050b89cd90e2128979d8):
#    extract the AppImage, run its installer without the package check, then move
#    Resolve's bundled glib aside so it uses Fedora's.
# 3. Install the FFmpeg encoder plugin (github.com/EdvinNilsson/ffmpeg_encoder_plugin)
#    into /opt/resolve/IOPlugins. H.264/H.265/AV1 export via x264/x265/SVT-AV1 and
#    VAAPI/Vulkan/NVENC.
set -euo pipefail
[[ -z "${DOTFILES_CHECK:-}" ]] || exit 0   # set by .github/check.sh

force=0
[[ "${1:-}" == "--force" ]] && force=1

resolve=/opt/resolve
resolve_stamp="$resolve/.dotfiles-version"   # written after a successful install
plugins="$resolve/IOPlugins"
plugin_bundle="$plugins/ffmpeg_encoder_plugin.dvcp.bundle"
plugin_stamp="$plugin_bundle/.dotfiles-version"
work="${XDG_CACHE_HOME:-$HOME/.cache}/davinci-install"

say() { printf '\n\e[1m==> %s\e[0m\n' "$*"; }

for tool in curl unzip python3; do
    command -v "$tool" >/dev/null || { echo "davinci: needs $tool" >&2; exit 1; }
done

cleanup() { rm -rf "$work"; }
trap cleanup EXIT

# --- Resolve ------------------------------------------------------------------
say "Checking the latest DaVinci Resolve Studio"
read -r version download_id < <(curl -fsSL \
    https://www.blackmagicdesign.com/api/support/latest-stable-version/davinci-resolve-studio/linux |
    python3 -c 'import json, sys
d = json.load(sys.stdin)["linux"]
print("%s.%s.%s-%s" % (d["major"], d["minor"], d["releaseNum"], d["build"]), d["downloadId"])')
installed="$(cat "$resolve_stamp" 2>/dev/null || echo none)"
echo "    latest $version, installed $installed"

if [[ "$installed" == "$version" && "$force" == 0 ]]; then
    echo "    already up to date"
else
    # zip + extracted .run + extracted AppImage, with room to spare
    mkdir -p "$work"
    free_gb=$(( $(df --output=avail -k "$work" | tail -1) / 1024 / 1024 ))
    if (( free_gb < 40 )); then
        echo "davinci: needs about 40 GB free in $work (has ${free_gb} GB)" >&2
        exit 1
    fi

    say "Getting a download link from Blackmagic"
    url="$(python3 - "$download_id" <<'PYEOF'
import json, sys, urllib.request
payload = {"firstname": "Resolve", "lastname": "User", "email": "resolve-user@example.com",
           "phone": "0000000000", "country": "us", "street": "Main Street",
           "state": "New York", "city": "New York", "product": "DaVinci Resolve Studio"}
req = urllib.request.Request(
    f"https://www.blackmagicdesign.com/api/register/us/download/{sys.argv[1]}",
    data=json.dumps(payload).encode(), method="POST",
    headers={"Content-Type": "application/json;charset=UTF-8",
             "User-Agent": "Mozilla/5.0 (X11; Linux x86_64)",
             "Referer": "https://www.blackmagicdesign.com/support/download/"})
print(urllib.request.urlopen(req).read().decode().strip())
PYEOF
)"
    [[ "$url" == https://* ]] || { echo "davinci: Blackmagic didn't return a download link: $url" >&2; exit 1; }

    say "Downloading Resolve Studio $version (about 11.5 GB)"
    curl -fL --retry 3 -C - -o "$work/resolve.zip" "$url"
    unzip -q -o "$work/resolve.zip" -d "$work"
    run="$(find "$work" -maxdepth 1 -name 'DaVinci_Resolve_Studio_*_Linux.run' | head -n1)"
    [[ -n "$run" ]] || { echo "davinci: no installer in the download" >&2; exit 1; }
    rm -f "$work/resolve.zip"

    say "Installing (the installer asks for confirmation and your password)"
    chmod +x "$run"
    (cd "$work" && "$run" --appimage-extract >/dev/null)
    rm -f "$run"
    (cd "$work/squashfs-root" && SKIP_PACKAGE_CHECK=1 ./AppRun -i)

    say "Using Fedora's glib instead of Resolve's bundled copy"
    sudo mkdir -p "$resolve/libs/disabled_libraries"
    shopt -s nullglob
    bundled=("$resolve"/libs/libglib* "$resolve"/libs/libgio* "$resolve"/libs/libgmodule*)
    shopt -u nullglob
    if ((${#bundled[@]})); then
        sudo mv -f "${bundled[@]}" "$resolve/libs/disabled_libraries/"
    fi

    echo "$version" | sudo tee "$resolve_stamp" >/dev/null
    echo "    Resolve Studio $version installed"
fi

# --- FFmpeg encoder plugin ----------------------------------------------------
say "Checking the FFmpeg encoder plugin"
[[ -d "$resolve" ]] || { echo "davinci: $resolve is missing, so Resolve isn't installed" >&2; exit 1; }
tag="$(curl -fsSL https://api.github.com/repos/EdvinNilsson/ffmpeg_encoder_plugin/releases/latest |
    python3 -c 'import json, sys; print(json.load(sys.stdin)["tag_name"])')"
have="$(cat "$plugin_stamp" 2>/dev/null || echo none)"
echo "    latest $tag, installed $have"

if [[ "$have" == "$tag" ]]; then
    echo "    already up to date"
else
    mkdir -p "$work"
    curl -fsSL -o "$work/plugin.zip" \
        "https://github.com/EdvinNilsson/ffmpeg_encoder_plugin/releases/download/$tag/ffmpeg_encoder_plugin.dvcp.bundle.zip"
    sudo mkdir -p "$plugins"
    sudo rm -rf "$plugin_bundle"
    sudo unzip -q -o "$work/plugin.zip" -d "$plugins"
    echo "$tag" | sudo tee "$plugin_stamp" >/dev/null
    echo "    plugin $tag installed"
fi

say "Done. Start Resolve from the launcher; Studio asks for its licence key on first start."
