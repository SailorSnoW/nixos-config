{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpanel
  ];

  xdg.configFile.hyprpanel = {
    source = ../../dotfiles/hyprpanel;
  };
}
