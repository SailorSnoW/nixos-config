# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common
    ../common/desktop.nix
    inputs.apple-silicon-support.nixosModules.apple-silicon-support
  ];

  # FIXME: Added for stremio installation, should care about it !!!!
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    consoleLogLevel = 0;
    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=50"
      "appledrm.show_notch=1"
    ];
    loader.efi.canTouchEfiVariables = false;
  };

  hardware = {
    asahi = {
      peripheralFirmwareDirectory = ./firmware;
      setupAsahiSound = true;
    };

    graphics.enable = true;

    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  powerManagement = {
    enable = true;
  };

  networking.hostName = "snow-nixos"; # Define your hostname.

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  users.users.snow = {
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "render"
      "input"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    pipes-rs
    cmatrix
    cbonsai
    niri
    podman-tui
    podman-compose
    light
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
  ];

  services = {
    # Bluetooth pairing
    blueman.enable = true;

    upower.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
  };

  # Enable common container config files in /etc/containers
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.niri.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    4444
  ]; # SSH port
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
