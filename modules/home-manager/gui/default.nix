{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./rofi.nix
    ./spotify-player.nix
    ./ghostty.nix

    ./niri
  ];

  home.file = {
    "Pictures/wallpapers" = {
      source = ../../../home-manager/assets/wallpapers;
    };
  };

  home.packages = with pkgs; [
    signal-desktop
    vesktop
    wl-clipboard
    cliphist
    stremio
  ];

  # GTK
  gtk = {
    enable = true;
  };
}
