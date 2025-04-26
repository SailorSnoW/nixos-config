{ pkgs, ... }:
{
  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  networking.hostName = "snow_pc_wsl";

  environment.enableAllTerminfo = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    neovim
    tmux
    fastfetch
    htop
    unzip
  ];
  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  # uncomment the next line to enable SSH
  # services.openssh.enable = true;

  users.users = {
    snow = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
  };

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "snow";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
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

  system.stateVersion = "24.05";
}
