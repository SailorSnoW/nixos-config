CRUSH.md — Commands and Coding Guidelines

Build / Lint / Test
- Flake eval & checks:
  - nix flake check
- Update inputs:
  - nix flake update
- NixOS build (no switch):
  - nix build .#nixosConfigurations.asahi.config.system.build.toplevel
- NixOS switch (Asahi host):
  - sudo nixos-rebuild switch --flake .#asahi
- Home Manager switch (user snow on asahi):
  - home-manager switch --flake .#snow@asahi
- Format Nix files:
  - nix fmt
- Lint Nix (dead code, style) with statix & deadnix if available:
  - statix check
  - deadnix --fail
- Validate Lua configs (Neovim):
  - nvim --headless "+lua print('ok')" +qa
  - lua -l luacheck (if luacheck configured)
- Run a single test: this repo has no test suite; if adding tests, prefer flake.nix checks or run nix build .#checks.<system>.<name>

Code Style Guidelines
- Languages: Nix for system/home modules; Lua for Neovim; minimal shell.
- Imports/Modules: Prefer small reusable modules under modules/{nixos,home-manager}; pass specialArgs via flake outputs; avoid cyclic imports.
- Formatting: Run nix fmt; keep lines ≤ 100 chars; 2-space indent; in Lua follow stylua defaults if added.
- Types & Options: Use mkOption with explicit types; set sensible defaults; document options.
- Naming: hyphen-case for files (e.g., netdata.nix); lowerCamel for Nix attrs; snake_case for Lua locals; descriptive, not abbreviated.
- Immutability: Favor let-bindings and lib.mk* helpers; prefer mkIf over conditionals spread across modules.
- Overlays/Packages: Put custom packages in pkgs/ and expose via overlays; keep derivations pure and pinned by flake inputs.
- Error handling: Validate with assertions in Nix (assert cond; "message"); fail early on missing inputs.
- Secrets: Never commit secrets; use age/sops or environment. Do not log secrets.
- Neovim: Lazy-load plugins; keep plugin configs in modules/home-manager/neovim/lua/plugins/*.lua; avoid global state.

AI Assistant Notes
- No Cursor or Copilot rules found in repo.
- When adding tests, wire them under outputs.checks and use nix flake check for CI-like runs.
- Prefer reproducible commands; avoid non-flake nix-env usage.
