# darwin/configuration.nix
{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # FIX: For unknown reason, Neovim on darwin with the neovim.nix wouldn't use any of the extraPackages passed, so we need to pass it directly to the system-level.

    # LSPs
    nixd
    lua-language-server
    gcc
    go
    php
    # Formatters
    alejandra
    stylua
    prettierd
    shfmt

    # Others
    ripgrep
    fd
    lazygit
    unzip
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.snow = {
    name = "snow";
    home = "/Users/snow";
  };
}
