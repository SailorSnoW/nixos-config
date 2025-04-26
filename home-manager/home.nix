{ inputs, pkgs, ... }:
{
  # You can import other home-manager modules here
  imports = [
    inputs.textfox.homeManagerModules.default

    ../modules/home-manager/nushell.nix
    ../modules/home-manager/neovim/default.nix
    ../modules/home-manager/fastfetch.nix
    ../modules/home-manager/yazi.nix
    # ../modules/home-manager/streamrip.nix FIXME:
    ../modules/home-manager/spotify-player.nix
    ./gui
  ];

  home.packages = with pkgs; [
    cava
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  home.file = {
    "Pictures/fastfetch_logos" = {
      source = ./assets/fastfetch;
      recursive = true;
    };
    "Pictures/wallpapers" = {
      source = ./assets/wallpapers;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
  programs.git = {
    enable = true;
    userName = "SailorSnoW";
    userEmail = "sailorsnow@pm.me";
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
  programs.lazygit.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
