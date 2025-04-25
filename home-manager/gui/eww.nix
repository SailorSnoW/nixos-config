{
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile.eww = {
    source = ../../dotfiles/eww;
  };
}
