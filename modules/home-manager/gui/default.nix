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
    obsidian
    godot_4_3-mono
  ];

  # GTK
  gtk = {
    enable = true;
  };
}
