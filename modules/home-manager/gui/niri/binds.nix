{ config, ... }:
{
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      # Fn keys
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "10%-";
      "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "10%+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_SINK@" "5%-";
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_SINK@" "5%+";
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_SINK@" "toggle";

      # General actions
      "Mod+Q".action = close-window;
      "Mod+L".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+Alt+H".action = swap-window-left;
      "Mod+Alt+L".action = swap-window-right;
      "Mod+Alt+F".action = toggle-window-floating;
      "Mod+Alt+P".action = switch-preset-column-width;
      "Mod+Alt+M".action = maximize-column;
      "Mod+Shift+apostrophe".action = screenshot;

      # Workspaces
      "Mod+J".action = focus-workspace-down;
      "Mod+K".action = focus-workspace-up;
      "Mod+Alt+J".action = move-window-to-workspace-down;
      "Mod+Alt+K".action = move-window-to-workspace-up;
      "Mod+ampersand".action = focus-workspace 1;
      "Mod+eacute".action = focus-workspace 2;
      "Mod+quotedbl".action = focus-workspace 3;
      "Mod+apostrophe".action = focus-workspace 4;
      "Mod+parenleft".action = focus-workspace 5;
      "Mod+section".action = focus-workspace 6;

      # Sizing
      "Mod+Shift+Plus".action = set-column-width "+10%";
      "Mod+Minus".action = set-column-width "-10%";

      # Shortcuts
      "Mod+T".action = spawn "wezterm";
      "Mod+B".action = spawn "wezterm" "start" "btop";
      "Mod+F".action = spawn "wezterm" "start" "yazi";
      "Mod+space".action = spawn "rofi" "-show" "drun";
    };
  };
}
