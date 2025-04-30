{ inputs, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./wezterm.nix
    ./firefox.nix
    ./rofi.nix
    ./hyprpanel.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./spotify-player.nix
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

    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  # GTK
  gtk = {
    enable = true;
  };
}
