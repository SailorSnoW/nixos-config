# ❄️ Personal NixOS configs

This repository contains my personal NixOS and Nix-Darwin configurations.  
It’s designed to easily bootstrap and maintain various environments, including WSL, Asahi Linux on Apple Silicon, and macOS.

My daily driver is my **Asahi Linux configuration** — a polished and complete setup focused on performance and flexibility.

---

## 🚀 Usage

### 💽 Deploying to a New Machine

1. **Clone the repository**:

   ```bash
   git clone https://github.com/SailorSnow/nixos-config.git
   cd nixos-config
   ```

2. **Rebuild the system using a flake configuration**:

   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

   Example for WSL:

   ```bash
   sudo nixos-rebuild switch --flake .#wsl
   ```

   Example for Asahi Linux:

   ```bash
   sudo nixos-rebuild switch --flake .#asahi
   ```

   Example for macOS (Darwin):

   ```bash
   darwin-rebuild switch --flake .#darwin
   ```

---

## 🔄 Updating Inputs

To update all external sources (e.g., nixpkgs, home-manager):

```bash
nix flake update
```

---

## 🏡 Main Systems

| Hostname                        | Description                          | Notes                                        |
| :------------------------------ | :----------------------------------- | :------------------------------------------- |
| `asahi`                         | Asahi Linux (M2)                     | 🌟 **Main personal workstation**             |
| `wsl`                           | NixOS on Windows WSL2                | Minimalist and lightweight environment       |
| `darwin`                        | macOS with Nix-Darwin + Home Manager | For macOS-specific workflows                 |
| `serverBase` + `serverHomelab*` | Homelab servers (personal)           | Internal infrastructure (less relevant here) |

The **Asahi Linux setup** is the most complete and heavily used one, designed for daily productivity, development, and multimedia.

---

## 📦 Structure Overview

This flake is modular, with clean separation between:

- **Hosts**: Configurations per machine (`./hosts/`)
- **Home Manager**: User-specific settings (`./home-manager/`)
- **Custom Packages**: Personal and third-party packages (`./pkgs/`)
- **Modules**: Reusable NixOS and Home Manager modules (`./modules/`)

---

## ❄️ Notes

This is a personal configuration, tailored to my workflow and hardware.  
Feel free to explore and adapt it to your own setups!
