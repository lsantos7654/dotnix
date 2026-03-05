# dotnix

NixOS system configuration with switchable desktop profiles.

## Desktop Profiles

| Profile | Desktop | Display | nixpkgs | Command |
|---------|---------|---------|---------|---------|
| `nixos-kde6` | Plasma 6 | Wayland | nixos-unstable | `sudo nixos-rebuild switch --flake ~/dotnix#nixos-kde6` |
| `nixos-kde5` | Plasma 5.27.11 | X11 | nixos-23.11 | `sudo nixos-rebuild switch --flake ~/dotnix#nixos-kde5` |

## Structure

```
dotnix/
├── flake.nix                   # Dual nixpkgs inputs, two nixosConfigurations
├── shared/
│   ├── hardware-configuration.nix
│   ├── system.nix              # Boot, networking, locale, NVIDIA, audio, user
│   ├── packages.nix            # Composable package lists (core, gaming)
│   └── wallpapers/             # Multi-monitor spanning wallpapers
├── desktops/
│   ├── kde6/
│   │   ├── default.nix         # Plasma 6 system config + Home Manager
│   │   ├── plasma/             # plasma-manager theme, shortcuts, panels, window rules
│   │   ├── firefox/            # Firefox-Mod-Blur custom CSS
│   │   └── patches/            # kde-rounded-corners KWin region patch
│   └── kde5/
│       ├── default.nix         # Plasma 5 system config + Home Manager
│       └── plasma/             # plasma-manager theme, shortcuts, panels, window rules
```

Shared system config lives in `shared/`. Each desktop profile in `desktops/` adds DE-specific settings, packages, and Home Manager modules. User-level config (shell, editor, terminal) is managed by [dothome](https://github.com/lsantos7654/dothome) and imported as a flake input.

## Switching Desktops

```bash
# Plasma 6 + Wayland (daily driver)
sudo nixos-rebuild switch --flake ~/dotnix#nixos-kde6

# Plasma 5.27.11 + X11
sudo nixos-rebuild switch --flake ~/dotnix#nixos-kde5
```

## Updating

```bash
nix flake update --flake ~/dotnix
```

## Hardware

ASUS Z690-E, Intel CPU, NVIDIA RTX 50-series (open drivers on KDE6, proprietary on KDE5), triple 2560x1440 monitors, KVM support.

## Theme

Both profiles use the same visual setup: Ant-Dark theme, Papirus icons, Kvantum, vim-style shortcuts (Meta+hjkl), Krohnkite tiling, and transparent window rules.
