{
  programs.niri.settings = {
    window-rules = [
      # Global rules
      {
        geometry-corner-radius =
          let
            r = 12.0;
          in
          {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
        clip-to-geometry = true;
      }
      {
        # Wezterm
        matches = [
          { app-id = "^org\.wezfurlong\.wezterm$"; }
        ];
        open-floating = true;
      }
      {
        # Discord
        matches = [
          { app-id = "^(vesktop)$"; }
        ];
        open-on-workspace = "chat";
        open-maximized = true;
      }
      {
        # Firefox
        matches = [
          { app-id = "^(firefox)$"; }
        ];
        open-on-workspace = "browser";
        open-maximized = true;
      }
      {
        # Signal
        matches = [
          { app-id = "^(signal)$"; }
        ];
        open-on-workspace = "chat";
      }
      {
        # Sound control
        matches = [
          { app-id = "^org\.pulseaudio\.pavucontrol$"; }
        ];
        default-column-width = {
          proportion = 0.50;
        };
        default-window-height = {
          fixed = 500;
        };
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "top-right";
        };
      }

    ];

  };
}
