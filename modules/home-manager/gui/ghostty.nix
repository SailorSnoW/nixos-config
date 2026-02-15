{
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  isLinux = !isDarwin;
in
{
  programs.ghostty = {
    enable = true;
    package = if isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;

    settings = {
      theme = "Rose Pine Moon";
      background-opacity = 0.8;

      window-padding-x = 10;
      window-padding-y = 10;

      click-repeat-interval = 0;
      confirm-close-surface = false;
    }
    // lib.optionalAttrs isLinux {
      font-size = 12;
      font-family = "FiraCode Nerd Font Mono";
      window-height = 23;
      window-width = 80;
      background-blur = true;
      window-vsync = false;
      window-decoration = "none";
      focus-follows-mouse = true;
    }
    // lib.optionalAttrs isDarwin {
      # macOS specific - larger for Retina display
      font-size = 15;
      font-thicken = true;
      font-family = "FiraCode Nerd Font Mono Ret";
      window-height = 30;
      window-width = 100;
      window-vsync = true;
      background-blur = true;
      macos-titlebar-style = "transparent";
      macos-option-as-alt = true;
      focus-follows-mouse = true;

      # Keybindings
      keybind = [
        # Splits
        "super+d=new_split:right"
        "super+shift+d=new_split:down"
        # Navigation entre splits (vim-style)
        "super+h=goto_split:left"
        "super+l=goto_split:right"
        "super+j=goto_split:bottom"
        "super+k=goto_split:top"
        # Resize splits (Cmd+Ctrl + vim keys)
        "super+ctrl+h=resize_split:left,50"
        "super+ctrl+l=resize_split:right,50"
        "super+ctrl+k=resize_split:up,50"
        "super+ctrl+j=resize_split:down,50"
        # Maximize/zoom
        "super+alt+m=toggle_fullscreen"
        "super+shift+enter=toggle_split_zoom"
      ];
    };
  };
}
