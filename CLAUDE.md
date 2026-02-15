# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Rebuild system (primary command)
sudo nixos-rebuild switch --flake .#asahi

# Home Manager only (ad-hoc)
home-manager switch --flake .#snow@asahi

# Check flake syntax and evaluate
nix flake check

# Build system closure without switching (dry run)
nix build .#nixosConfigurations.asahi.config.system.build.toplevel

# Update all flake inputs
nix flake update

# Build custom package
nix build .#tentrackule
```

## Architecture

This is a Nix Flakes-based NixOS configuration with integrated Home Manager. Two hosts are configured:
- **asahi**: Apple Silicon (Asahi Linux) with full desktop GUI
- **wsl**: Windows Subsystem for Linux, headless

### Key Directories

- `hosts/asahi/`, `hosts/wsl/` - Host-specific configurations
- `hosts/common/` - Shared host settings (boot, locale, users, desktop)
- `home-manager/home.nix` - User configuration entry point
- `modules/nixos/` - Reusable NixOS modules
- `modules/home-manager/` - Reusable Home Manager modules (terminal tools, GUI apps)
- `overlays/` - Nixpkgs overlays
- `pkgs/` - Custom packages

### Conditional GUI Loading

GUI modules are conditionally imported based on the `enableGui` parameter passed via `extraSpecialArgs` in flake.nix. The asahi host sets `enableGui = true`, while wsl sets `enableGui = false`.

### Module Organization

Home Manager modules in `modules/home-manager/` are split between:
- Terminal/CLI tools (zsh, neovim, btop, yazi, fastfetch)
- GUI applications in `gui/` subdirectory (firefox, ghostty, rofi, waybar, niri)

Neovim configuration uses `mnw` (Minimal Neovim Wrapper) with Lua plugin configs in `modules/home-manager/neovim/lua/`.

### Desktop Stack

- Wayland compositor: Niri (configured via greetd)
- Theming: Stylix with Rose Pine Moon
- Status bar: Waybar
- Launcher: Rofi
- Terminal: Ghostty
