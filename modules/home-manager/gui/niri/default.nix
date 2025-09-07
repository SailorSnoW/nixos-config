{ pkgs, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gnome
        pkgs.gnome-keyring
      ];
      configPackages = [ pkgs.niri ];
    };
  };

  home.packages = with pkgs; [
    swww
    wev
  ];

  # Use native Niri config file instead of NixOS settings
  home.file.".config/niri/config.kdl".source = ../../../../dotfiles/niri/config.kdl;
}
