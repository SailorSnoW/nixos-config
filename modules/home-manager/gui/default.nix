{ pkgs, ... }:
{
  imports = [
    ./wezterm.nix
    ./firefox.nix
    ./rofi.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./spotify-player.nix
    ./waybar.nix
    ./mako.nix

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
    obsidian
  ];

  # GTK
  gtk = {
    enable = true;
  };
}
