{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./wezterm.nix
    ./firefox.nix
    ./rofi.nix
    ./eww.nix
    # ./waybar.nix
    # ./mako.nix
    ./hyprpanel.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    vesktop
    wl-clipboard
    cliphist
  ];

  # GTK
  gtk = {
    enable = true;
  };
}
