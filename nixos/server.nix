# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  users.users = {
    snow = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDim5Twm04AwCwfj4SrVEZvW0ubVBnGccDQRBgmb2IzUp4HeKx0eoa1SQkpe7ZA2IYtp3H3k16jRmE1X1h7DMygrj5HS7er45/2y9P1zTJpWJQGgchoFRpaOtbLexAI7bJ1OiKDNCpim0BSmDs2r3QGlamc/mtGbmXU9qb8B6t/+/8oW/B6P2BlxuJg2CJTfPxvFRqXCSDKjIJNCgc3qN+ThZTrg9GmznUUIuS+gQDcnSKLRmo6b09eUdKNggfFY+J4W/dM9ZrElNKkl/6tLBepBGTNwGmqkDGHjMCOeAPKcU9aeRBnFEG0d9BcdtWB1J7Sow4JoYm9jFA9aq4AB/OwbWH99KAVSuIouW5EFsuTtjHSzGPg+WzzcrQRGgJWb41Zw6C1YjNq5i/AbjVcqY1k90TkbGftszrE4YJicEoFP37nRNoNTHAxYaogN/lBbds8OCEijALpXb+5u/4vCy6NRNtzSGSPwy5xX6jU968UCpDz8tgGTXSkk/5765WTRW8= snxwin@pm.me"
      ];
      extraGroups = ["wheel" "docker" "network" "adm"];
    };
  };

  console.keyMap = "fr";

  environment.systemPackages = with pkgs; [
    git
    curl
    neovim
    tmux
    fastfetch
    htop
    podman
    podman-compose
  ];
  programs.zsh.enable = true;

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };


  # Time sync
  services.ntp = {
    enable = true;
    servers = [ "pool.ntp.org" ];   
  };
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  services.fail2ban = {
    enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "03:00";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
