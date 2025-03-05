# The host of the homelab
{pkgs, ...}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "homelab";

  # try to automatically start these MicroVMs on bootup
  microvm.autostart = [];

  services.xserver.xkb.layout = "fr";
  console.keyMap = "fr";

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    fastfetch
  ];
  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  # uncomment the next line to enable SSH
  # services.openssh.enable = true;

  users.users = {
    snow = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDim5Twm04AwCwfj4SrVEZvW0ubVBnGccDQRBgmb2IzUp4HeKx0eoa1SQkpe7ZA2IYtp3H3k16jRmE1X1h7DMygrj5HS7er45/2y9P1zTJpWJQGgchoFRpaOtbLexAI7bJ1OiKDNCpim0BSmDs2r3QGlamc/mtGbmXU9qb8B6t/+/8oW/B6P2BlxuJg2CJTfPxvFRqXCSDKjIJNCgc3qN+ThZTrg9GmznUUIuS+gQDcnSKLRmo6b09eUdKNggfFY+J4W/dM9ZrElNKkl/6tLBepBGTNwGmqkDGHjMCOeAPKcU9aeRBnFEG0d9BcdtWB1J7Sow4JoYm9jFA9aq4AB/OwbWH99KAVSuIouW5EFsuTtjHSzGPg+WzzcrQRGgJWb41Zw6C1YjNq5i/AbjVcqY1k90TkbGftszrE4YJicEoFP37nRNoNTHAxYaogN/lBbds8OCEijALpXb+5u/4vCy6NRNtzSGSPwy5xX6jU968UCpDz8tgGTXSkk/5765WTRW8= snxwin@pm.me"
      ];
      extraGroups = ["wheel"];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  nix = {
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Automate `nix store --optimise`
      auto-optimise-store = true;
    };
  };

  system.stateVersion = "24.11";
}
