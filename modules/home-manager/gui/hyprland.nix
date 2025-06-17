{
  pkgs,
  config,
  lib,
  ...
}:
let
  rgba = color: alpha: "rgba(${color}${alpha})";
in
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.hyprland ];
    };
  };

  home.packages = with pkgs; [
    hyprpolkitagent
    hyprland-qtutils
    hyprshot
    wev
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # UWSM conflicts if true
    systemd.enable = false;
    xwayland = {
      enable = true;
    };

    settings = {
      exec-once = [
        "uwsm finalize"

        # Bar
        "uwsm app hyprpanel"
        # Discord
        "uwsm app vesktop"

        # Main workspace
        "uwsm app -- wezterm start --class spotify bash -c 'sleep 5; spotify_player'"
        "uwsm app -- wezterm start --class cava 'cava'"
        "uwsm app -- wezterm start --class cowsay bash -c 'cowsay Have A Great Day, SnoW 🌙'"
      ];

      "$mod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 15;

        # Override stylix border color with transparency
        "col.active_border" = lib.mkForce (rgba config.lib.stylix.colors.base0D "80");
        "col.inactive_border" = lib.mkForce (rgba config.lib.stylix.colors.base03 "90");

        resize_on_border = true;
        border_size = 2;
        layout = "dwindle";

        snap = {
          enabled = true;
        };
      };

      input = {
        kb_layout = "fr";
        kb_variant = "mac";
        kb_options = "eurosign:e,caps:escape";
        repeat_delay = 300;

        touchpad = {
          scroll_factor = 0.3;
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = false;
          tap-to-click = false;
        };
      };

      decoration = {
        rounding = 12;

        blur = {
          enabled = true;
          xray = true;
          size = 5;
          passes = 3;
          vibrancy = 0.1696;
          new_optimizations = true;
          popups = true;
          popups_ignorealpha = 0.6;
        };

        shadow = {
          enabled = true;
          range = 20;
          render_power = 2;
        };

      };
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      render = {
        explicit_sync = 2;
        explicit_sync_kms = 2;
        direct_scanout = true;
      };

      bind = [
        # Launch shortcuts
        "$mod, T, exec, uwsm app -- wezterm start --class wezterm_float"
        "$mod SHIFT, T, exec, uwsm app wezterm"
        "$mod, Q, killactive"
        # Manual lock
        # "$mod LALT, L, exec, uwsm app -- hyprlock"
        "$mod, SPACE, exec, rofi -show drun -run-command 'uwsm app -- {cmd}'"
        "$mod, F, exec, uwsm app -- wezterm start --class yazi yazi"
        "$mod SHIFT, B, exec, uwsm app -- wezterm start --class btop btop"
        "$mod SHIFT, apostrophe, exec, uwsm app -- hyprshot -m region"
        # Run spotify client, focus if already exist
        "$mod, S, exec, pgrep spotify_player && hyprctl dispatch focuswindow class:spotify || uwsm app -- wezterm start --class spotify spotify_player"

        # Fn keys
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_SINK@ 5%-"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_SINK@ 5%+"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_SINK@ toggle"

        # Floating
        "$mod SHIFT, F, togglefloating"

        # Workspaces (AZERTY layout)
        "$mod, ampersand, workspace, 1"
        "$mod, eacute, workspace, 2"
        "$mod, quotedbl, workspace, 3"
        "$mod, apostrophe, workspace, 4"
        "$mod, parenleft, workspace, 5"
        "$mod, minus, workspace, 6"
        "$mod, egrave, workspace, 7"
        "$mod, underscore, workspace, 8"
        "$mod, ccedilla, workspace, 9"

        # Move to workspace
        "$mod ALT, ampersand, movetoworkspace, 1"
        "$mod ALT, eacute, movetoworkspace, 2"
        "$mod ALT, quotedbl, movetoworkspace, 3"
        "$mod ALT, apostrophe, movetoworkspace, 4"
        "$mod ALT, parenleft, movetoworkspace, 5"
        "$mod ALT, minus, movetoworkspace, 6"
        "$mod ALT, egrave, movetoworkspace, 7"
        "$mod ALT, underscore, movetoworkspace, 8"
        "$mod ALT, ccedilla, movetoworkspace, 9"
        "$mod ALT, l, workspace, e+1"
        "$mod ALT, h, workspace, e-1"

        # Focus modification
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"

        # Resizing
        "$mod SHIFT, h, resizeactive, -10 0"
        "$mod SHIFT, l, resizeactive, 10 0"
        "$mod SHIFT, j, resizeactive, 0 10"
        "$mod SHIFT, k, resizeactive, 0 -10"
      ];

      bindm = [
        "$mod,mouse:272,movewindow"
      ];

      windowrulev2 = [
        "workspace 1, class:^(vesktop)$"
        "workspace 2, class:^(cava)$"
        "workspace 2, class:^(cowsay)$"
        "workspace 2, class:^(spotify)$"
        "workspace 3, class:^(firefox)$"

        # Dialog windows – float+center these windows.
        "center, title:^(Open File)(.*)$"
        "center, title:^(Select a File)(.*)$"
        "center, title:^(Choose wallpaper)(.*)$"
        "center, title:^(Open Folder)(.*)$"
        "center, title:^(Save As)(.*)$"
        "center, title:^(Library)(.*)$"
        "center, title:^(File Upload)(.*)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(File Upload)(.*)$"

        # Floating Apps
        "float, class:^(yazi).*$"
        "float, class:^(btop).*$"
        "float, class:^(cava).*$"
        "float, class:^(spotify).*$"
        "float, class:^(cowsay).*$"
        "float, class:^(wezterm_float).*$"

        # Resizing
        "size 50% 30%, class:^(cava).*$"
        "size 30% 20%, class:^(cowsay).*$"
        "size 35% 70%, class:^(spotify).*$"

        # Screen position
        "move 15 670, class:^(cava).*$"
        "move 125 115, class:^(cowsay).*$"
        "move 950 125, class:^(spotify).*$"
      ];

      layerrule = [
        "blur, rofi"
      ];

      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        allow_session_lock_restore = true;
      };

      env = [
        "HYPRCURSOR_THEME, rose-pine-hyprcursor"
        "XCURSOR_SIZE, 24"
        "NIXOS_OZONE_WL, 1"
        "MOZ_ENABLE_WAYLAND, 1"
        "CLUTTER_BACKEND, wayland"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_DECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 2"
        "GDK_SCALE, 1"
        "QT_SCALE_FACTOR, 1"
        # pavucontrol didn't work without this one
        "GSK_RENDERER, gl"
        "EDITOR, nvim"
      ];
    };
  };
}
