# .dotfiles

My personal setup on top of [Hafnium](https://github.com/euandeas/hafnium), a minimal
Fedora with niri and Dux (DMS). Everything is declared in mise
([bootstrap](https://mise.jdx.dev/bootstrap.html) +
[dotfiles](https://mise.jdx.dev/dotfiles.html)).

## Quick start

1. Install Hafnium from the [ISO](https://github.com/euandeas/hafnium/releases/tag/latest)
   (the NVIDIA ISO if needed).
2. Log in and bootstrap:

```sh
hjust bootstrap-dotfiles euandeas/.dotfiles
# which runs:
mise bootstrap --from https://github.com/euandeas/.dotfiles.git --from-dir ~/.dotfiles --config-dir . --force-dotfiles
```

Optional extras are mise config environments:

```sh
mise -E gaming bootstrap              # Steam, Bottles, Prism Launcher
mise -E tailscale bootstrap           # Tailscale + tailscaled
```

Re-running `mise bootstrap` is safe. It converges: it installs what's missing and
re-links what has drifted.

## How it layers on Hafnium

`--config-dir .` links `~/.config/mise` to this checkout, so [`config.toml`](config.toml)
is mise's **global** config. Hafnium's defaults
([hdots](https://github.com/euandeas/hdots)) are mise's **system** config
(`/etc/mise/conf.d/hafnium.toml`). For any target both declare, this repo wins:

| Target | Hafnium default | Here |
|---|---|---|
| `~/.config/niri/config.kdl` | managed entrypoint | (left to Hafnium) |
| `~/.config/niri/local.kdl` | empty seed | [`home/niri/local.kdl`](home/niri/local.kdl): animations, flat mouse, window rules, Alt-Tab |
| `~/.config/ghostty/config` | seed | [`home/ghostty/config`](home/ghostty/config): Commit Mono, DMS colours |
| `~/.config/niri/dms/binds.kdl` | seed | (left to Hafnium / DMS) |
| `~/.config/dms/settings.json` | seed (Flexoki theme) | [`home/dms/settings.json`](home/dms/settings.json): my full DMS layout, still using Hafnium's Flexoki theme |
| `~/.local/state/dms/session.json` | seed (Flexoki orb wallpapers, per light/dark mode) | (left to Hafnium / DMS) |

## Layout

```
config.toml               packages, system files, services, hooks, [dotfiles]
config.gaming.toml        mise -E gaming
config.tailscale.toml     mise -E tailscale
home/                     dotfile sources (symlinked into ~)
  bashrc  ghostty/  niri/local.kdl  dms/settings.json  zed/  fonts/
system/
  repos/                  → /etc/yum.repos.d/ (Brave, GitHub CLI)
  firewalld/localsend.xml → /etc/firewalld/services/ (port 53317 tcp/udp)
  scripts/firewall.sh     post-dotfiles: allow syncthing + localsend in the default zone
  scripts/git-identity.sh bootstrap task: prompt for git name/email once
```

## Day to day

```sh
mise dot status           # what's applied / drifted
mise dot apply            # re-link
git -C ~/.dotfiles pull && mise bootstrap   # pull this repo and converge
hjust update              # system update
```
