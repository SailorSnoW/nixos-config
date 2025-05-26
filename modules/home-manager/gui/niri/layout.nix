{
  programs.niri.settings = {
    layout = {
      gaps = 15;
      struts = {
        left = -4;
        right = -4;
        top = -4;
        bottom = -4;
      };

      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];

      always-center-single-column = true;

      border = {
        enable = true;
        width = 2;
      };

      shadow = {
        enable = true;
        draw-behind-window = false;
        softness = 15;
        spread = 6;
      };

      tab-indicator.hide-when-single-tab = true;
    };

  };
}
