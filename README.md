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

### 🪟 Deploy on WSL2 (Windows)

1) Install [NixOS-WSL](https://github.com/nix-community/NixOS-WSL): download `nixos.wsl` from the latest release, then

```powershell
wsl --install --from-file nixos.wsl
```

2) Inside the distro, clone the repository and apply the flake (use `boot`, not `switch`, so the default user change from `nixos` to `snow` is applied cleanly)

```bash
sudo nixos-rebuild boot --flake .#wsl
```

3) Restart the distro from PowerShell

```powershell
wsl -t NixOS
wsl -d NixOS --user root exit
wsl -t NixOS
```

Subsequent rebuilds from inside WSL:

```bash
sudo nixos-rebuild switch --flake .#wsl
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

## 🖥️ Hosts

- `asahi`: Asahi Linux on Apple Silicon (daily driver)
- `wsl`: NixOS on WSL2, headless — same CLI tooling, no GUI modules
- `darwin`: macOS via nix-darwin

—

## 📦 Repository Structure

- `flake.nix`/`flake.lock`: Flake entry and locked inputs
- `hosts/`
  - `asahi/`: Host configuration (imports Apple Silicon support)
  - `wsl/`: NixOS-WSL host configuration (headless)
  - `darwin/`: macOS (nix-darwin) host configuration
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
