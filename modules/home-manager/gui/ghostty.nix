{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "rose-pine-moon";
      font-size = 12;
      font-family = "FiraCode Nerd Font Mono";
      background-opacity = 0.8;
      background-blur = true;

      # Care on MacOS if false
      window-vsync = false;
      window-decoration = "none";
      window-padding-x = 10;
      window-padding-y = 10;
      window-height = 23;
      window-width = 80;

      focus-follows-mouse = true;
      click-repeat-interval = 0;

      confirm-close-surface = false;
    };
  };
}
