{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      local config = wezterm.config_builder()

      config.use_fancy_tab_bar = true
      config.hide_tab_bar_if_only_one_tab = true
      config.window_background_opacity = 0.8
      config.exit_behavior = 'Hold'
      config.exit_behavior_messaging = 'None'

      return config
    '';
  };
}
