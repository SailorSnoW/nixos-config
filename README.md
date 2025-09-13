# ❄️ Personal NixOS configs

This repository contains my personal NixOS configuration, primarily targeting Apple Silicon via Asahi Linux. Home Manager is integrated into NixOS builds.

—

## 🚀 Usage

### 💽 Deploy on the machine

1) Clone the repository

```bash
git clone https://github.com/SailorSnow/nixos-config.git
cd nixos-config
```

2) Rebuild the system (Asahi host)

```bash
sudo nixos-rebuild switch --flake .#asahi
```

Optional: Home Manager only (ad‑hoc)

```bash
home-manager switch --flake .#snow@asahi
```

—

## 🔧 Build, Test, Update

- Evaluate/check flake:
  ```bash
  nix flake check
  ```
- Build system closure (dry):
  ```bash
  nix build .#nixosConfigurations.asahi.config.system.build.toplevel
  ```
- Update inputs:
  ```bash
  nix flake update
  ```

—

## 🖥️ Host

- `asahi`: Asahi Linux on Apple Silicon (daily driver)

—

## 📦 Repository Structure

- `flake.nix`/`flake.lock`: Flake entry and locked inputs
- `hosts/`
  - `asahi/`: Host configuration (imports Apple Silicon support)
  - `common/`: Shared host glue (`boot.nix`, `locale.nix`, `desktop.nix`, `users.nix`)
- `home-manager/`: User config and assets; applied via system rebuilds
- `modules/`
  - `modules/nixos/`: Reusable NixOS modules (e.g., `netdata.nix`, `minecraft-server-*.nix`)
  - `modules/home-manager/`: Reusable HM modules (e.g., `zsh.nix`, `neovim/`, `gui/`)
- `overlays/`: Overlays including an `unstable` package set
- `pkgs/`: Custom packages (e.g., `tentrackule`)
- `dotfiles/`: Misc dotfiles not managed as HM modules

—

## 🧩 Notable Choices

- Wayland compositor: Niri (via `services.greetd` session)
- Stylix for theming and fonts
- Podman (Docker‑compat) enabled with DNS for compose
- Bluetooth via BlueZ + Blueman
- Home Manager modules for Zsh, Neovim (nixCats), GUI apps (Firefox, Ghostty, etc.)

—

## ❄️ Notes

This is a personal setup tuned for my hardware and workflow. Feel free to explore and adapt it.
