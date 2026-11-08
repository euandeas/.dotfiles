# .dotfiles

My setup on top of [Hafnium](https://github.com/euandeas/hafnium), declared with
[mise bootstrap](https://mise.jdx.dev/bootstrap.html).

## Install

On a fresh Hafnium install:

```sh
hjust bootstrap-dotfiles euandeas/.dotfiles
```

Extras:

```sh
mise -E gaming bootstrap      # Steam, Bottles, Prism Launcher
mise -E tailscale bootstrap   # Tailscale
```

## Contents

| Path | What |
|---|---|
| [`config.toml`](config.toml) | packages, flatpaks, repos, services, dotfiles; ends by syncing the login screen to my DMS settings |
| `config.gaming.toml`, `config.tailscale.toml` | the extras above |
| [`home/`](home) | bash, Ghostty, niri `local.kdl`, DMS layout, Zed, fonts |
| [`system/`](system) | Brave and GitHub CLI repos, firewall rules for Syncthing and LocalSend, git identity prompt |

This repo becomes mise's global config, so it overrides Hafnium's defaults wherever
both set the same file.

## Updating

```sh
git -C ~/.dotfiles pull && mise bootstrap
```
