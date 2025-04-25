{ outputs, pkgs, ... }:
{
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

  boot.loader = {
    systemd-boot.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    git
    curl
    tmux
    fastfetch
    neovim
    ripgrep
    fd
    lazygit
    unzip
    just
    wget
    direnv
    htop
    wev
  ];

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  # Time sync
  services.ntp = {
    enable = true;
    servers = [ "pool.ntp.org" ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.variant = "mac";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  users.users = {
    snow = {
      isNormalUser = true;
      shell = pkgs.nushell;
    };
  };
}
