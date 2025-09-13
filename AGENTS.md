# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix`/`flake.lock`: Flake entry and locked inputs.
- `hosts/`: Per‑machine system configs (e.g., `asahi/`, `wsl/`, `darwin/`). Put hardware‑ or host‑specific options here.
- `home-manager/`: User config and assets; Home Manager is integrated into NixOS/Darwin builds.
- `modules/`: Reusable modules
  - `modules/nixos/`: NixOS modules (e.g., `netdata.nix`, `minecraft-server-*.nix`).
  - `modules/home-manager/`: HM modules (e.g., `zsh.nix`, `neovim/`, `gui/`).
- `pkgs/`: Custom packages exposed via flake outputs.
- `overlays/`: Overlays including an `unstable` package set.
- `dotfiles/`: Misc dotfiles not managed as HM modules.

## Build, Test, and Development Commands
- Rebuild NixOS: `sudo nixos-rebuild switch --flake .#asahi` (or `.#wsl`).
- Rebuild macOS: `darwin-rebuild switch --flake .#darwin`.
- Evaluate/check flake: `nix flake check`.
- Build a system closure (dry): `nix build .#nixosConfigurations.asahi.config.system.build.toplevel`.
- Update inputs: `nix flake update`.
- Home Manager only (ad‑hoc): `home-manager switch --flake .#snow@asahi` (HM is normally applied via system rebuilds).

## Coding Style & Naming Conventions
- Nix: 2‑space indentation, concise attribute sets, keep imports/inputs grouped at top.
- Filenames: kebab‑case for modules (`minecraft-server-pixelmon.nix`), lower‑case dirs.
- Prefer small, focused modules under `modules/`; host‑specific glue belongs in `hosts/<name>/`.
- Formatting: use `alejandra -q .` or `nixpkgs-fmt .` before committing.

## Testing Guidelines
- Always run `nix flake check` after changes.
- For NixOS/Darwin edits, build the target host closure to catch evaluation errors.
- For HM/module changes, validate by rebuilding a representative host that imports them.
- Keep changes minimal and reversible; avoid mixing unrelated edits.

## Commit & Pull Request Guidelines
- Commit messages: imperative and scoped. Examples:
  - `feat(asahi): enable niri and podman`
  - `fix(hm/zsh): correct zoxide integration`
  - `chore(overlays): expose unstable set as pkgs.unstable`
- PRs should include: clear summary, affected hosts/modules, commands run (e.g., `nixos-rebuild`/`flake check`), and any relevant screenshots for desktop tweaks.
- Link related issues and note any breaking changes or manual steps.

## Security & Configuration Tips
- Do not commit secrets; prefer `sops/age` workflows stored outside this repo or via sops‑nix (if added later).
- Keep hardware‑specific options in `hosts/`; keep reusable logic in `modules/`.
