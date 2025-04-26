{
  inputs,
  lib,
  config,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # Enable this if running in a LXC proxmox container
    # outputs.nixosModules.proxmox-lxc

    ./hardware-configuration.nix

    ../common/default.nix
  ];

  # In case this is a container context we don't want this
  boot = lib.mkIf (!config.boot.isContainer) {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  users.users = {
    snow = {
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDim5Twm04AwCwfj4SrVEZvW0ubVBnGccDQRBgmb2IzUp4HeKx0eoa1SQkpe7ZA2IYtp3H3k16jRmE1X1h7DMygrj5HS7er45/2y9P1zTJpWJQGgchoFRpaOtbLexAI7bJ1OiKDNCpim0BSmDs2r3QGlamc/mtGbmXU9qb8B6t/+/8oW/B6P2BlxuJg2CJTfPxvFRqXCSDKjIJNCgc3qN+ThZTrg9GmznUUIuS+gQDcnSKLRmo6b09eUdKNggfFY+J4W/dM9ZrElNKkl/6tLBepBGTNwGmqkDGHjMCOeAPKcU9aeRBnFEG0d9BcdtWB1J7Sow4JoYm9jFA9aq4AB/OwbWH99KAVSuIouW5EFsuTtjHSzGPg+WzzcrQRGgJWb41Zw6C1YjNq5i/AbjVcqY1k90TkbGftszrE4YJicEoFP37nRNoNTHAxYaogN/lBbds8OCEijALpXb+5u/4vCy6NRNtzSGSPwy5xX6jU968UCpDz8tgGTXSkk/5765WTRW8= snxwin@pm.me"
      ];
      extraGroups = [
        "wheel"
        "docker"
        "network"
        "adm"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  services.tailscale.enable = true;

  # As we decide to not use any password for our primary wheel user
  security.sudo.wheelNeedsPassword = false;

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
