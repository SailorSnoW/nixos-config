{ outputs, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./users.nix
    ./locale.nix
  ];

  nix = {
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      warn-dirty = false;
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Automate `nix store --optimise`
      auto-optimise-store = true;
    };

  };
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      outputs.overlays.hyprpanel

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config.allowUnfree = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    tmux
    fastfetch
    neovim
    unzip
    wget
    direnv
    htop
  ];
  programs.zsh.enable = true;

  services.logind.powerKey = "ignore";
}
