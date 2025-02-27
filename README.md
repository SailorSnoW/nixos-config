# ❄️  My NixOS Configurations 

This repository contains my NixOS configurations for my homelab servers and WSL setup. It’s designed to easily bootstrap new machines, whether physical servers, virtual machines, or WSL on Windows.

---

## 🚀 Usage

### 🖥 Deploying to a New Machine

1. **Clone the repo**:
   ```bash
   git clone https://github.com/SailorSnow/nixos-config.git
   cd your-nixos-repo
   ```
2. **Deploy a configuration (e.g WSL environment)**
    ```bash
    sudo nixos-rebuild switch --flake .#wsl
    ```

---

## 🔄 Updating Inputs

To update inputs (e.g., nixpkgs, home-manager):

```bash
nix flake update
```

---

## 🏠 Home Manager

These configs use Home Manager with a config for user snow located in home-manager/home.nix. It’s included in all NixOS configs for a consistent user experience.
