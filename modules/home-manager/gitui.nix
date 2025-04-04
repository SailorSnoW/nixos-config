{
  programs.gitui.enable = true;

  xdg.configFile.gitui = {
    source = ../../dotfiles/gitui;
  };
  xdg.configFile."gitui/theme.ron".enable = false;
}
