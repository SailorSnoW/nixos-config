# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal NixOS configuration repository using Nix flakes that manages multiple system configurations including Asahi Linux (Apple Silicon), macOS via Nix-Darwin, WSL, and various homelab servers. The main daily driver configuration is the Asahi Linux setup.

## Common Commands

### System Rebuilds

- **NixOS systems**: `sudo nixos-rebuild switch --flake .#<hostname>`
  - Asahi Linux: `sudo nixos-rebuild switch --flake .#asahi`
  - WSL: `sudo nixos-rebuild switch --flake .#wsl`
  - Servers: `sudo nixos-rebuild switch --flake .#serverBase` (or other server configurations)

- **macOS (Darwin)**: `darwin-rebuild switch --flake .#darwin`

### Flake Management

- **Update all inputs**: `nix flake update`
- **Update specific input**: `nix flake update <input-name>`
- **Show flake info**: `nix flake show`
- **Check flake**: `nix flake check`

### Development and Testing

- **Build without switching**: `nixos-rebuild build --flake .#<hostname>`
- **Test configuration**: `nixos-rebuild test --flake .#<hostname>`
- **Dry run**: `nixos-rebuild dry-run --flake .#<hostname>`

## Architecture

### Directory Structure

- **`flake.nix`**: Main flake configuration defining all system outputs and inputs
- **`hosts/`**: Host-specific configurations
  - `asahi/`: Asahi Linux configuration (Apple Silicon M2)
  - `darwin/`: macOS configuration 
  - `wsl/`: Windows WSL2 configuration
  - `common/`: Shared NixOS modules (boot, users, locale, desktop)
  - `servers/`: Homelab server configurations
- **`home-manager/`**: User environment configuration using Home Manager
- **`modules/`**: Custom reusable modules
  - `nixos/`: Custom NixOS modules
  - `home-manager/`: Custom Home Manager modules 
  - `homelab/`: Homelab-specific modules
- **`overlays/`**: Nixpkgs overlays for custom packages and modifications
- **`pkgs/`**: Custom package definitions

### Key Configurations

- **Main workstation**: `asahi` configuration using nixpkgs-unstable with Niri window manager, Home Manager, and Stylix theming
- **GUI applications**: Conditionally enabled via `enableGui` parameter in Home Manager
- **Multiple user environments**: All systems use the same `home-manager/home.nix` with conditional GUI imports

### Flake Inputs

- `nixpkgs` (24.11) and `nixpkgs-unstable`: Base package sets
- `home-manager`: User environment management
- `nixos-wsl`: WSL2 integration
- `darwin`: macOS system management
- `apple-silicon-support`: Asahi Linux hardware support
- `niri`: Niri window manager
- `nixCats`: Neovim configuration framework
- `stylix`: System-wide theming
- `textfox`: Firefox theme

### Module System

The configuration uses a modular approach:

- **Host configurations** import common modules and host-specific hardware configurations
- **Home Manager modules** are organized by functionality (GUI apps, CLI tools, development tools)
- **Conditional imports** based on system type (desktop vs server) and GUI requirements
- **Overlays** provide unstable packages and custom modifications

### Special Features

- **Cross-platform**: Supports Linux (NixOS), macOS (Darwin), and WSL
- **Hardware-specific**: Asahi Linux configuration with Apple Silicon optimizations
- **Containerization**: Podman setup with Docker compatibility
- **Development environment**: Includes Rust toolchain, Neovim with LSP, and various development tools
- **Homelab services**: Server configurations for self-hosted applications